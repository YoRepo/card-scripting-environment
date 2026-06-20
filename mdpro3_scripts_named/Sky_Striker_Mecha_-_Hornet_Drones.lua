--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 闪刀机-大黄蜂浮游单元  (ID: 52340444)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 277
--
-- Effect Text:
-- ①：自己的主要怪兽区域没有怪兽存在的场合才能发动。在自己场上把1只「闪刀姬衍生物」（战士族·暗·1星·攻/守0）守备表示特殊召唤。这衍生物不能解放。自己墓地有魔法卡3张以上存在的场合，那衍生物的攻击力
-- ·守备力变成1500。
--[[ __CARD_HEADER_END__ ]]

--閃刀機－ホーネットビット
function c52340444.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCondition(c52340444.condition)
	e1:SetTarget(c52340444.target)
	e1:SetOperation(c52340444.activate)
	c:RegisterEffect(e1)
end
function c52340444.cfilter(c)
	return c:GetSequence()<5
end
function c52340444.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c52340444.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c52340444.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local atk=0
	if Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_SPELL)>=3 then
		atk=1500
	end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,52340445,0,TYPES_TOKEN_MONSTER,atk,atk,1,RACE_WARRIOR,ATTRIBUTE_DARK,POS_FACEUP_DEFENSE) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c52340444.activate(e,tp,eg,ep,ev,re,r,rp)
	local atk=0
	if Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_SPELL)>=3 then
		atk=1500
	end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,52340445,0,TYPES_TOKEN_MONSTER,atk,atk,1,RACE_WARRIOR,ATTRIBUTE_DARK,POS_FACEUP_DEFENSE) then return end
	local token=Duel.CreateToken(tp,52340445)
	if Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP_DEFENSE) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UNRELEASABLE_SUM)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		token:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UNRELEASABLE_NONSUM)
		token:RegisterEffect(e2)
		if Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_SPELL)>=3 then
			local e3=Effect.CreateEffect(e:GetHandler())
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_SET_ATTACK)
			e3:SetValue(1500)
			e3:SetReset(RESET_EVENT+RESETS_STANDARD)
			token:RegisterEffect(e3)
			local e4=e3:Clone()
			e4:SetCode(EFFECT_SET_DEFENSE)
			token:RegisterEffect(e4)
		end
	end
	Duel.SpecialSummonComplete()
end
