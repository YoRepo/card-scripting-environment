--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 蚂蚁的增殖  (ID: 22493811)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 祭掉自己场上1只昆虫族怪兽发动。在自己场上特殊召唤2只「兵队衍生物」（地·4星·昆虫族·攻500·守1200）。（不能用作上级召唤的祭品）
--[[ __CARD_HEADER_END__ ]]

--アリの増殖
function c22493811.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c22493811.cost)
	e1:SetTarget(c22493811.target)
	e1:SetOperation(c22493811.activate)
	c:RegisterEffect(e1)
end
function c22493811.costfilter(c,tp)
	return c:IsRace(RACE_INSECT)
		and Duel.GetMZoneCount(tp,c)>1 and (c:IsControler(tp) or c:IsFaceup())
end
function c22493811.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c22493811.costfilter,1,nil,tp) end
	local g=Duel.SelectReleaseGroup(tp,c22493811.costfilter,1,1,nil,tp)
	Duel.Release(g,REASON_COST)
end
function c22493811.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local res=e:GetLabel()==1 or Duel.GetLocationCount(tp,LOCATION_MZONE)>1
	if chk==0 then
		e:SetLabel(0)
		return res and not Duel.IsPlayerAffectedByEffect(tp,59822133)
			and Duel.IsPlayerCanSpecialSummonMonster(tp,22493812,0,TYPES_TOKEN_MONSTER,500,1200,4,RACE_INSECT,ATTRIBUTE_EARTH)
	end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c22493811.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsPlayerCanSpecialSummonMonster(tp,22493812,0,TYPES_TOKEN_MONSTER,500,1200,4,RACE_INSECT,ATTRIBUTE_EARTH) then
		for i=1,2 do
			local token=Duel.CreateToken(tp,22493812)
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UNRELEASABLE_SUM)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetValue(1)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			token:RegisterEffect(e1,true)
		end
		Duel.SpecialSummonComplete()
	end
end
