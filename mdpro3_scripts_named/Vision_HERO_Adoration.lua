--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 幻影英雄 崇拜人  (ID: 45170821)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Warrior
-- Level 8
-- ATK 2800 | DEF 2100
-- Setcode: 20488
--
-- Effect Text:
-- 「英雄」怪兽×2
-- ①：1回合1次，以对方场上1只表侧表示怪兽和这张卡以外的自己场上1只「英雄」怪兽为对象才能发动。那只对方怪兽的攻击力·守备力直到回合结束时下降那只自己怪兽的攻击力数值。
--[[ __CARD_HEADER_END__ ]]

--V・HERO アドレイション
function c45170821.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x8),2,true)
	--summon success
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(45170821,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c45170821.valtg)
	e2:SetOperation(c45170821.valop)
	c:RegisterEffect(e2)
end
c45170821.material_setcode=0x8
function c45170821.sfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x8)
end
function c45170821.valtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil)
		and Duel.IsExistingTarget(c45170821.sfilter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPPO)
	local g1=Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
	e:SetLabelObject(g1:GetFirst())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELF)
	Duel.SelectTarget(tp,c45170821.sfilter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
end
function c45170821.valop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local o=e:GetLabelObject()
	local s=g:GetFirst()
	if s==o then s=g:GetNext() end
	if s:IsFaceup() and o:IsFaceup() and s:IsRelateToEffect(e) and o:IsRelateToEffect(e) then
		local val=s:GetAttack()*-1
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(val)
		o:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		o:RegisterEffect(e2)
	end
end
