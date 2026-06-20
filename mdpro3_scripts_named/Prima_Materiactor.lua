--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 第一原质炉  (ID: 57448410)
-- Type: Monster / Normal / Pendulum
-- Attribute: LIGHT
-- Race: Dragon
-- Level 3
-- Pendulum Scales: L1 / R1
-- ATK 0 | DEF 0
-- Setcode: 352
--
-- Effect Text:
-- ←1 【灵摆】 1→
-- 这个卡名的②的灵摆效果1回合只能使用1次。
-- ①：自己场上的超量怪兽的攻击力上升场上的超量素材数量×100。
-- ②：以自己场上1只「原质炉」超量怪兽为对象才能发动。把这张卡作为那只怪兽的超量素材。那之后，自己抽1张。
-- 【怪兽描述】
-- 从遥远彼端的天上界突然飞来的外来生命体。虽有众多研究者力图查明真身，但其发放的光辉和弥漫的瘴气导致长久以来其存在被谜团所笼罩，想要一睹全貌极为困难。然而，近年来，经过新进研究者的一番努力发现了许多新种
-- 。揭开其全貌的日子想必也已临近。
--[[ __CARD_HEADER_END__ ]]

--プリマ・マテリアクトル
local s,id,o=GetID()
function s.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_PZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_XYZ))
	e1:SetValue(s.val)
	c:RegisterEffect(e1)
	--material
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1,id)
	e2:SetTarget(s.mattg)
	e2:SetOperation(s.matop)
	c:RegisterEffect(e2)
end
function s.val(e,c)
	return Duel.GetOverlayCount(e:GetHandlerPlayer(),1,1)*100
end
function s.matfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x160) and c:IsType(TYPE_XYZ)
end
function s.mattg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and s.matfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(s.matfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsPlayerCanDraw(tp,1)
		and e:GetHandler():IsCanOverlay() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,s.matfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function s.matop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) and c:IsCanOverlay() then
		Duel.Overlay(tc,Group.FromCards(c))
		Duel.BreakEffect()
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
