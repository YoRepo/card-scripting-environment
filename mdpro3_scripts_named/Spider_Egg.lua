--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 蜘蛛卵  (ID: 56051648)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方宣言直接攻击时，自己墓地昆虫族怪兽有3只以上存在的场合才能发动。把那只怪兽的攻击无效，在自己场上把3只「蜘蛛衍生物」（昆虫族·地·1星·攻/守100）攻击表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--スパイダー・エッグ
function c56051648.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c56051648.condition)
	e1:SetTarget(c56051648.target)
	e1:SetOperation(c56051648.activate)
	c:RegisterEffect(e1)
end
function c56051648.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.GetAttackTarget()==nil
		and Duel.IsExistingMatchingCard(Card.IsRace,tp,LOCATION_GRAVE,0,3,nil,RACE_INSECT)
end
function c56051648.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.GetAttacker()
	if chk==0 then return tg:IsOnField() and not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>=3
		and Duel.IsPlayerCanSpecialSummonMonster(tp,56051649,0,TYPES_TOKEN_MONSTER,100,100,1,RACE_INSECT,ATTRIBUTE_EARTH,POS_FACEUP_ATTACK) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,3,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,3,0,0)
end
function c56051648.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if Duel.NegateAttack() and Duel.GetLocationCount(tp,LOCATION_MZONE)>2
		and Duel.IsPlayerCanSpecialSummonMonster(tp,56051649,0,TYPES_TOKEN_MONSTER,100,100,1,RACE_INSECT,ATTRIBUTE_EARTH,POS_FACEUP_ATTACK) then
		for i=1,3 do
			local token=Duel.CreateToken(tp,56051649)
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP_ATTACK)
		end
		Duel.SpecialSummonComplete()
	end
end
