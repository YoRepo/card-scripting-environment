--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 魔界剧团-恶魔反派  (ID: 52240819)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Fiend
-- Level 8
-- Pendulum Scales: L1 / R1
-- ATK 3000 | DEF 2000
-- Setcode: 4332
--
-- Effect Text:
-- ←1 【灵摆】 1→
-- ①：1回合1次，把自己场上1只「魔界剧团」怪兽解放，以对方场上1只表侧表示怪兽为对象才能发动。那只怪兽的攻击力直到回合结束时下降解放的怪兽的原本攻击力数值。
-- 【怪兽效果】
-- ①：这张卡召唤·特殊召唤成功的场合，以对方场上1只表侧表示怪兽为对象才能发动。那只怪兽的攻击力直到回合结束时下降自己场上的「魔界剧团」怪兽数量×1000。
-- ②：这张卡战斗破坏对方怪兽时，以自己墓地1张「魔界台本」魔法卡为对象才能发动。那张卡在自己场上盖放。
--[[ __CARD_HEADER_END__ ]]

--魔界劇団－デビル・ヒール
function c52240819.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--atk down (p zone)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(52240819,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c52240819.atkcost1)
	e1:SetTarget(c52240819.atktg1)
	e1:SetOperation(c52240819.atkop1)
	c:RegisterEffect(e1)
	--atk down (summon)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetTarget(c52240819.atktg2)
	e2:SetOperation(c52240819.atkop2)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--set
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCategory(CATEGORY_SSET)
	e4:SetCode(EVENT_BATTLE_DESTROYING)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCondition(aux.bdocon)
	e4:SetTarget(c52240819.settg)
	e4:SetOperation(c52240819.setop)
	c:RegisterEffect(e4)
end
function c52240819.atkcost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsSetCard,1,nil,0x10ec) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsSetCard,1,1,nil,0x10ec)
	e:SetLabel(g:GetFirst():GetBaseAttack())
	Duel.Release(g,REASON_COST)
end
function c52240819.atktg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
end
function c52240819.atkop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-e:GetLabel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c52240819.atkfilter(c)
	return c:IsSetCard(0x10ec) and c:IsFaceup()
end
function c52240819.atktg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil)
		and Duel.IsExistingMatchingCard(c52240819.atkfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
end
function c52240819.atkop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local atkval=Duel.GetMatchingGroupCount(c52240819.atkfilter,tp,LOCATION_MZONE,0,nil)*1000
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-atkval)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c52240819.cfilter(c)
	return c:IsSetCard(0x20ec) and c:IsType(TYPE_SPELL) and c:IsSSetable()
end
function c52240819.settg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c52240819.cfilter(chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(c52240819.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectTarget(tp,c52240819.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
end
function c52240819.setop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SSet(tp,tc)
	end
end
