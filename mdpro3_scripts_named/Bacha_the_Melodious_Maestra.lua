--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 幻奏的音姬 壮丽之巴赫  (ID: 56208713)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Fairy
-- Level 7
-- ATK 2500 | DEF 1800
-- Setcode: 4251
--
-- Effect Text:
-- 「幻奏」怪兽×2
-- 这个卡名的①③的效果1回合各能使用1次。
-- ①：这张卡特殊召唤的场合才能发动。从卡组把1只「幻奏」怪兽特殊召唤。
-- ②：只要融合召唤的这张卡在怪兽区域存在，自己的「幻奏」融合怪兽发动的效果不会被无效化。
-- ③：这张卡被送去墓地的场合，以「幻奏的音姬 壮丽之巴赫」以外的自己墓地1只「幻奏」怪兽为对象才能发动。那只怪兽守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--幻奏の音姫スペクタキュラー・バッハ
local s,id,o=GetID()
function s.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x9b),2,true)
	--spsummon_deck
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	--inactivatable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_DISEFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(s.inacon)
	e2:SetValue(s.effectfilter)
	c:RegisterEffect(e2)
	--spsummon_grave
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCountLimit(1,id+o)
	e3:SetTarget(s.sptg1)
	e3:SetOperation(s.spop1)
	c:RegisterEffect(e3)
end
function s.spfilter(c,e,tp)
	return c:IsSetCard(0x9b) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP) end
end
function s.inacon(e)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function s.effectfilter(e,ct)
	local p=e:GetHandler():GetControler()
	local te,tp=Duel.GetChainInfo(ct,CHAININFO_TRIGGERING_EFFECT,CHAININFO_TRIGGERING_PLAYER)
	return p==tp and te:GetHandler():IsSetCard(0x9b) and te:IsActiveType(TYPE_FUSION)
end
function s.spfilter1(c,e,tp)
	return not c:IsCode(id) and c:IsSetCard(0x9b) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function s.sptg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and s.spfilter1(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(s.spfilter1,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,s.spfilter1,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function s.spop1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetTargetsRelateToChain()
	if tc then Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_DEFENSE) end
end
