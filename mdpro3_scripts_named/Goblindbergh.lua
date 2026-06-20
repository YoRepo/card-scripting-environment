--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 哥布林德伯格  (ID: 25259669)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 4
-- ATK 1400 | DEF 0
-- Setcode: 172
--
-- Effect Text:
-- ①：这张卡召唤时才能发动。从手卡把1只4星以下的怪兽特殊召唤。这张卡是攻击表示的场合，再让这张卡变成守备表示。
--[[ __CARD_HEADER_END__ ]]

--ゴブリンドバーグ
function c25259669.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(25259669,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c25259669.sumtg)
	e1:SetOperation(c25259669.sumop)
	c:RegisterEffect(e1)
end
function c25259669.filter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c25259669.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c25259669.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c25259669.sumop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c25259669.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
		if g:GetCount()>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)>0
			and c:IsRelateToEffect(e) and c:IsPosition(POS_FACEUP_ATTACK) then
			Duel.BreakEffect()
			Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
		end
	end
end
