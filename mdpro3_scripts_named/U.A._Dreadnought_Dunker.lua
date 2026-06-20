--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 超级运动员 无畏扣篮手  (ID: 71279983)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 7
-- ATK 2500 | DEF 1800
-- Setcode: 178
--
-- Effect Text:
-- 「超级运动员 无畏扣篮手」的①的方法的特殊召唤1回合只能有1次。
-- ①：这张卡可以让「超级运动员 无畏扣篮手」以外的自己场上1只「超级运动员」怪兽回到手卡，从手卡特殊召唤。
-- ②：这张卡向守备表示怪兽攻击的场合，给与攻击力超过那个守备力的数值的战斗伤害。
-- ③：这张卡给与对方战斗伤害时，以场上1张卡为对象才能发动。那张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--U.A.ドレッドノートダンカー
function c71279983.initial_effect(c)
	--special summon rule
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCountLimit(1,71279983+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c71279983.spcon)
	e1:SetTarget(c71279983.sptg)
	e1:SetOperation(c71279983.spop)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DAMAGE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCondition(c71279983.descon)
	e3:SetTarget(c71279983.destg)
	e3:SetOperation(c71279983.desop)
	c:RegisterEffect(e3)
end
function c71279983.spfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0xb2) and not c:IsCode(71279983) and c:IsAbleToHandAsCost()
		and Duel.GetMZoneCount(tp,c)>0
end
function c71279983.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c71279983.spfilter,tp,LOCATION_MZONE,0,1,nil,tp)
end
function c71279983.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c71279983.spfilter,tp,LOCATION_MZONE,0,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c71279983.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.SendtoHand(g,nil,REASON_SPSUMMON)
end
function c71279983.descon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c71279983.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c71279983.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
