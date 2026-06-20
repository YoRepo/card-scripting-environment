--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: No.71 海异鲨  (ID: 59479050)
-- Type: Monster / Effect / Xyz
-- Attribute: WATER
-- Race: Dragon
-- Rank 3
-- ATK 0 | DEF 2000
-- Setcode: 72
--
-- Effect Text:
-- 3星怪兽×2
-- ①：1回合1次，以「No.71 海异鲨」以外的自己墓地1只「No.」超量怪兽为对象才能发动。那只怪兽特殊召唤，把这张卡1个超量素材在那只怪兽下面重叠作为超量素材。
-- ②：这张卡被送去墓地的场合才能发动。从卡组选1张「升阶魔法」魔法卡在卡组最上面放置。
--[[ __CARD_HEADER_END__ ]]

--No.71 リバリアン・シャーク
function c59479050.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddXyzProcedure(c,nil,3,2)
	--summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(59479050,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetCondition(c59479050.spcon)
	e1:SetTarget(c59479050.sptg)
	e1:SetOperation(c59479050.spop)
	c:RegisterEffect(e1)
	--to deck top
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(59479050,2))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetTarget(c59479050.tdtg)
	e2:SetOperation(c59479050.tdop)
	c:RegisterEffect(e2)
end
aux.xyz_number[59479050]=71
function c59479050.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayCount()>0
end
function c59479050.spfilter(c,e,tp)
	return c:IsSetCard(0x48) and c:IsType(TYPE_XYZ) and not c:IsCode(59479050) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c59479050.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c59479050.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c59479050.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c59479050.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c59479050.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)>0
		and c:IsRelateToEffect(e) and c:GetOverlayCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(59479050,1))
		local mg=c:GetOverlayGroup():Select(tp,1,1,nil)
		local oc=mg:GetFirst():GetOverlayTarget()
		Duel.Overlay(tc,mg)
		Duel.RaiseSingleEvent(oc,EVENT_DETACH_MATERIAL,e,0,0,0,0)
	end
end
function c59479050.tdfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsSetCard(0x95)
end
function c59479050.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c59479050.tdfilter,tp,LOCATION_DECK,0,1,nil)
		and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>1 end
end
function c59479050.tdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(59479050,3))
	local g=Duel.SelectMatchingCard(tp,c59479050.tdfilter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.ShuffleDeck(tp)
		Duel.MoveSequence(tc,SEQ_DECKTOP)
		Duel.ConfirmDecktop(tp,1)
	end
end
