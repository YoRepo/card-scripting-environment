--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 守墓的侦察者  (ID: 24317029)
-- Type: Monster / Effect / Toon
-- Attribute: DARK
-- Race: Spellcaster
-- Level 4
-- ATK 1200 | DEF 2000
-- Setcode: 46
--
-- Effect Text:
-- 反转：从自己的卡组中特殊召唤1张攻击力1500以下名称中带有「守墓」的怪兽卡。
--[[ __CARD_HEADER_END__ ]]

--墓守の偵察者
function c24317029.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(24317029,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c24317029.target)
	e1:SetOperation(c24317029.operation)
	c:RegisterEffect(e1)
end
function c24317029.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c24317029.filter(c,e,tp)
	return c:IsAttackBelow(1500) and c:IsSetCard(0x2e) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c24317029.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c24317029.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
