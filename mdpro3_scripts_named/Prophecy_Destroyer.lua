--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 魔导鬼士 迪亚勒  (ID: 56174248)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 6
-- ATK 2500 | DEF 1200
-- Setcode: 110
--
-- Effect Text:
-- 这张卡在墓地存在的场合，把自己墓地3张名字带有「魔导书」的魔法卡从游戏中除外才能发动。这张卡从墓地特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--魔導鬼士 ディアール
function c56174248.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(56174248,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCost(c56174248.spcost)
	e1:SetTarget(c56174248.sptg)
	e1:SetOperation(c56174248.spop)
	c:RegisterEffect(e1)
end
function c56174248.rfilter(c)
	return c:IsSetCard(0x106e) and c:IsType(TYPE_SPELL) and c:IsAbleToRemoveAsCost()
end
function c56174248.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c56174248.rfilter,tp,LOCATION_GRAVE,0,3,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c56174248.rfilter,tp,LOCATION_GRAVE,0,3,3,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c56174248.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c56174248.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
