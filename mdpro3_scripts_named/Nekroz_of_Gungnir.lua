--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 天枪龙之影灵衣  (ID: 74122412)
-- Type: Monster / Effect / Ritual
-- Attribute: WATER
-- Race: Spellcaster
-- Level 7
-- ATK 2500 | DEF 1700
-- Setcode: 180
--
-- Effect Text:
-- 「影灵衣」仪式魔法卡降临
-- 这张卡若非以只使用除7星以外的怪兽来作的仪式召唤则不能特殊召唤。这个卡名的①②的效果1回合各能使用1次。
-- ①：自己·对方回合，把这张卡从手卡丢弃，以自己场上1只「影灵衣」怪兽为对象才能发动。那只怪兽在这个回合不会被战斗·效果破坏。
-- ②：自己·对方回合，从手卡丢弃1张「影灵衣」卡，以场上1张卡为对象才能发动。那张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--グングニールの影霊衣
function c74122412.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.ritlimit)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,74122412)
	e2:SetCost(c74122412.indcost)
	e2:SetTarget(c74122412.indtg)
	e2:SetOperation(c74122412.indop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,74122413)
	e3:SetCost(c74122412.descost)
	e3:SetTarget(c74122412.destg)
	e3:SetOperation(c74122412.desop)
	c:RegisterEffect(e3)
end
function c74122412.mat_filter(c)
	return not c:IsLevel(7)
end
function c74122412.indcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c74122412.filter(c)
	return c:IsFaceup() and c:IsSetCard(0xb4)
end
function c74122412.indtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c74122412.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c74122412.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c74122412.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c74122412.indop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(1)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		tc:RegisterEffect(e2)
	end
end
function c74122412.cfilter(c)
	return c:IsSetCard(0xb4) and c:IsDiscardable()
end
function c74122412.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c74122412.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c74122412.cfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c74122412.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c74122412.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
