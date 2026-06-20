--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 黑羽-微风之布利兹  (ID: 89258906)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Winged Beast
-- Level 3
-- ATK 1100 | DEF 300
-- Setcode: 51
--
-- Effect Text:
-- 这张卡被魔法·陷阱·效果怪兽的效果从自己卡组加入手卡的场合，这张卡可以在自己场上特殊召唤。把这张卡作为同调素材的场合，不是名字带有「黑羽」的怪兽的同调召唤不能使用。
--[[ __CARD_HEADER_END__ ]]

--BF－そよ風のブリーズ
function c89258906.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(89258906,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_HAND)
	e1:SetCondition(c89258906.condition)
	e1:SetTarget(c89258906.target)
	e1:SetOperation(c89258906.operation)
	c:RegisterEffect(e1)
	--synchro limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetValue(c89258906.synlimit)
	c:RegisterEffect(e2)
end
function c89258906.synlimit(e,c)
	if not c then return false end
	return not c:IsSetCard(0x33)
end
function c89258906.condition(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0 and e:GetHandler():IsPreviousLocation(LOCATION_DECK) and e:GetHandler():IsPreviousControler(tp)
end
function c89258906.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c89258906.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
