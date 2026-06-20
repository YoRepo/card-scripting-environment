--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 调皮宝贝·脉冲娃  (ID: 81119816)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Thunder
-- Level 1
-- ATK 0 | DEF 2000
-- Setcode: 288
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：这张卡作为「调皮宝贝」怪兽的所用融合素材或者所用连接素材送去墓地的场合才能发动。从卡组把「调皮宝贝·脉冲娃」以外的1张「调皮宝贝」卡送去墓地。那之后，可以从手卡·卡组把「调皮宝贝·脉冲娃」以外的1
-- 只「调皮宝贝」怪兽守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--プランキッズ・パルス
function c81119816.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,81119816)
	e1:SetCondition(c81119816.tgcon)
	e1:SetTarget(c81119816.tgtg)
	e1:SetOperation(c81119816.tgop)
	c:RegisterEffect(e1)
end
function c81119816.tgcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=c:GetReasonCard()
	return c:IsLocation(LOCATION_GRAVE) and rc:IsSetCard(0x120) and r&(REASON_FUSION+REASON_LINK)~=0 and not c:IsReason(REASON_RETURN)
end
function c81119816.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c81119816.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c81119816.tgfilter(c)
	return c:IsSetCard(0x120) and c:IsAbleToGrave() and not c:IsCode(81119816)
end
function c81119816.spfilter(c,e,tp)
	return c:IsSetCard(0x120) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE) and not c:IsCode(81119816)
end
function c81119816.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c81119816.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	local g2=Duel.GetMatchingGroup(c81119816.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,g:GetFirst(),e,tp)
	if #g>0 and Duel.SendtoGrave(g,REASON_EFFECT)~=0 and g:GetFirst():IsLocation(LOCATION_GRAVE)
		and #g2>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.SelectYesNo(tp,aux.Stringid(81119816,0)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g2:Select(tp,1,1,nil)
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
