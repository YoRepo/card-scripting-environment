--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 超越龙 钻头矛颌翼龙  (ID: 30128445)
-- Type: Monster / Effect / Xyz
-- Attribute: WIND
-- Race: Dinosaur
-- Rank 6
-- ATK 3000 | DEF 2300
--
-- Effect Text:
-- 6星怪兽×2
-- 这个卡名的①③的效果1回合各能使用1次。
-- ①：把这张卡1个超量素材取除，以除外的1只自己的恐龙族怪兽为对象才能发动。那只怪兽特殊召唤。
-- ②：没有超量素材的这张卡用和怪兽的战斗给与对方的战斗伤害变成2倍。
-- ③：这张卡被破坏的场合才能发动。从自己墓地选1只通常怪兽回到卡组。那之后，可以把这张卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--超越竜ドリルグナトゥス
function c30128445.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,6,2)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(30128445,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,30128445)
	e1:SetCost(c30128445.spcost)
	e1:SetTarget(c30128445.sptg)
	e1:SetOperation(c30128445.spop)
	c:RegisterEffect(e1)
	--double
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CHANGE_INVOLVING_BATTLE_DAMAGE)
	e2:SetCondition(c30128445.damcon)
	e2:SetValue(aux.ChangeBattleDamage(1,DOUBLE_DAMAGE))
	c:RegisterEffect(e2)
	--special summon or self
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(30128445,1))
	e3:SetCategory(CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCountLimit(1,30128446)
	e3:SetTarget(c30128445.tdtg)
	e3:SetOperation(c30128445.tdop)
	c:RegisterEffect(e3)
end
function c30128445.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c30128445.spfilter(c,e,tp)
	return c:IsFaceup() and c:IsRace(RACE_DINOSAUR) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c30128445.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c30128445.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c30128445.spfilter,tp,LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c30128445.spfilter,tp,LOCATION_REMOVED,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c30128445.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c30128445.damcon(e)
	local c=e:GetHandler()
	return c:GetBattleTarget()~=nil and c:GetOverlayCount()==0
end
function c30128445.tdfilter(c)
	return c:IsType(TYPE_NORMAL) and c:IsAbleToDeck()
end
function c30128445.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c30128445.tdfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_GRAVE)
	if e:GetActivateLocation()==LOCATION_GRAVE then
		e:SetCategory(CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON+CATEGORY_GRAVE_SPSUMMON)
	else
		e:SetCategory(CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON)
	end
end
function c30128445.tdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c30128445.tdfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	if #g>0 then
		local c=e:GetHandler()
		if Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)>0
			and g:FilterCount(Card.IsLocation,nil,LOCATION_DECK)>0
			and c:IsRelateToEffect(e) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
			and Duel.SelectYesNo(tp,aux.Stringid(30128445,2)) then
			Duel.BreakEffect()
			Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
