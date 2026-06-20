--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 黑羽-苍炎之修罗  (ID: 58820853)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Winged Beast
-- Level 4
-- ATK 1800 | DEF 1200
-- Setcode: 51
--
-- Effect Text:
-- ①：这张卡战斗破坏对方怪兽送去墓地时才能发动。从卡组把1只攻击力1500以下的「黑羽」怪兽特殊召唤。这个效果特殊召唤的怪兽的效果无效化。
--[[ __CARD_HEADER_END__ ]]

--BF－蒼炎のシュラ
function c58820853.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(58820853,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(aux.bdogcon)
	e1:SetTarget(c58820853.target)
	e1:SetOperation(c58820853.operation)
	c:RegisterEffect(e1)
end
function c58820853.filter(c,e,tp)
	return c:IsAttackBelow(1500) and c:IsSetCard(0x33) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c58820853.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c58820853.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c58820853.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c58820853.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e2)
	end
end
