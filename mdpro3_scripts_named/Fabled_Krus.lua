--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 魔轰神 克露丝  (ID: 19439119)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fiend
-- Level 2
-- ATK 1000 | DEF 800
-- Setcode: 53
--
-- Effect Text:
-- ①：这张卡从手卡丢弃去墓地的场合，以自己墓地1只其他的4星以下的「魔轰神」怪兽为对象发动。那只怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--魔轟神クルス
function c19439119.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(19439119,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c19439119.spcon)
	e1:SetTarget(c19439119.sptg)
	e1:SetOperation(c19439119.spop)
	c:RegisterEffect(e1)
end
function c19439119.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_HAND) and bit.band(r,REASON_DISCARD)~=0
end
function c19439119.filter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsSetCard(0x35) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c19439119.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c19439119.filter(chkc,e,tp) and chkc~=e:GetHandler() end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c19439119.filter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler(),e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c19439119.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
