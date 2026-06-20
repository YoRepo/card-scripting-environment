--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 深绿之魔弓使  (ID: 55001420)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 3
-- ATK 900 | DEF 1400
--
-- Effect Text:
-- 若自己场上有植物族怪兽存在，则这张卡不能被攻击。每祭掉自己场上1只植物族怪兽，就能破坏场上1张魔法·陷阱卡。
--[[ __CARD_HEADER_END__ ]]

--深緑の魔弓使い
function c55001420.initial_effect(c)
	--cannot be battle target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetCondition(c55001420.ccon)
	e1:SetValue(aux.imval1)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(55001420,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c55001420.descost)
	e2:SetTarget(c55001420.destg)
	e2:SetOperation(c55001420.desop)
	c:RegisterEffect(e2)
end
function c55001420.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_PLANT)
end
function c55001420.ccon(e)
	return Duel.IsExistingMatchingCard(c55001420.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c55001420.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsRace,1,nil,RACE_PLANT) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsRace,1,1,nil,RACE_PLANT)
	Duel.Release(g,REASON_COST)
end
function c55001420.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c55001420.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c55001420.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c55001420.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c55001420.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c55001420.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
