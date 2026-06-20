--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 命运英雄 魔性人  (ID: 9411399)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level 6
-- ATK 800 | DEF 800
-- Setcode: 49160
--
-- Effect Text:
-- ①：把墓地的这张卡除外才能发动。从卡组把1只「命运英雄 魔性人」特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--D-HERO ディアボリックガイ
function c9411399.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9411399,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c9411399.target)
	e1:SetOperation(c9411399.operation)
	c:RegisterEffect(e1)
end
function c9411399.filter(c,e,sp)
	return c:IsCode(9411399) and c:IsCanBeSpecialSummoned(e,0,sp,false,false)
end
function c9411399.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c9411399.filter,tp,LOCATION_DECK,0,1,nil,e,tp)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c9411399.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local sc=Duel.GetFirstMatchingCard(c9411399.filter,tp,LOCATION_DECK,0,nil,e,tp)
	if sc then
		Duel.SpecialSummon(sc,0,tp,tp,false,false,POS_FACEUP)
	end
end
