--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 能朋克 鹿角仙符  (ID: 6609736)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 5
-- ATK 2100 | DEF 1800
-- Setcode: 369
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：把手卡1只其他的「朋克」怪兽给对方观看才能发动。手卡的这张卡和给人观看的怪兽之内1只特殊召唤，另1只送去墓地。
-- ②：这张卡从场上送去墓地的场合，以5星怪兽以外的自己墓地1只「朋克」怪兽为对象才能发动。那只怪兽特殊召唤。这个回合，自己不能把「能朋克 鹿角仙符」特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--No－P.U.N.K.ディア・ノート
local s,id,o=GetID()
function c6609736.initial_effect(c)
	--to grave and spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6609736,0))
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,6609736)
	e1:SetCost(c6609736.tgcost)
	e1:SetTarget(c6609736.tgtg)
	e1:SetOperation(c6609736.tgop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(6609736,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,6609736+o)
	e2:SetCondition(c6609736.spcon)
	e2:SetTarget(c6609736.sptg)
	e2:SetOperation(c6609736.spop)
	c:RegisterEffect(e2)
end
function c6609736.costfilter(c,ec,e,tp)
	if not c:IsSetCard(0x171) or not c:IsType(TYPE_MONSTER) or c:IsPublic() then return false end
	local g=Group.FromCards(c,ec)
	return g:IsExists(c6609736.tgspfilter,1,nil,g,e,tp)
end
function c6609736.tgspfilter(c,g,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and g:IsExists(Card.IsAbleToGrave,1,c)
end
function c6609736.tgcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c6609736.costfilter,tp,LOCATION_HAND,0,1,c,c,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local sc=Duel.SelectMatchingCard(tp,c6609736.costfilter,tp,LOCATION_HAND,0,1,1,c,c,e,tp):GetFirst()
	Duel.ConfirmCards(1-tp,sc)
	Duel.ShuffleHand(tp)
	sc:CreateEffectRelation(e)
	e:SetLabelObject(sc)
end
function c6609736.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c6609736.tgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sc=e:GetLabelObject()
	local g=Group.FromCards(c,sc)
	local fg=g:Filter(Card.IsRelateToEffect,nil,e)
	if fg:GetCount()~=2 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=fg:FilterSelect(tp,c6609736.tgspfilter,1,1,nil,fg,e,tp)
	if #sg>0 and Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)>0 then
		Duel.SendtoGrave(g-sg,REASON_EFFECT)
	end
end
function c6609736.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c6609736.spfilter(c,e,tp)
	return c:IsSetCard(0x171) and not c:IsLevel(5) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c6609736.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c6609736.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c6609736.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c6609736.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c6609736.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c6609736.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c6609736.splimit(e,c,tp,sumtp,sumpos)
	return c:IsCode(6609736)
end
