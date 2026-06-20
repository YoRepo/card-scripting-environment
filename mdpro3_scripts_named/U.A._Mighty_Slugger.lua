--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 超级运动员 猛力强击手  (ID: 56421754)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 5
-- ATK 2300 | DEF 700
-- Setcode: 178
--
-- Effect Text:
-- 「超级运动员 猛力强击手」的①的方法的特殊召唤1回合只能有1次。
-- ①：这张卡可以让「超级运动员 猛力强击手」以外的自己场上1只「超级运动员」怪兽回到手卡，从手卡特殊召唤。
-- ②：这张卡攻击的场合，对方直到伤害步骤结束时魔法·陷阱·怪兽的效果不能发动。
--[[ __CARD_HEADER_END__ ]]

--U.A.マイティスラッガー
function c56421754.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,56421754+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c56421754.spcon)
	e1:SetTarget(c56421754.sptg)
	e1:SetOperation(c56421754.spop)
	c:RegisterEffect(e1)
	--actlimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,1)
	e2:SetValue(1)
	e2:SetCondition(c56421754.actcon)
	c:RegisterEffect(e2)
end
function c56421754.spfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0xb2) and not c:IsCode(56421754) and c:IsAbleToHandAsCost()
		and Duel.GetMZoneCount(tp,c)>0
end
function c56421754.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c56421754.spfilter,tp,LOCATION_MZONE,0,1,nil,tp)
end
function c56421754.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c56421754.spfilter,tp,LOCATION_MZONE,0,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c56421754.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.SendtoHand(g,nil,REASON_SPSUMMON)
end
function c56421754.actcon(e)
	return Duel.GetAttacker()==e:GetHandler()
end
