--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 孤炎星-鲁猪深  (ID: 66762372)
-- Type: Monster / Effect / Tuner
-- Attribute: FIRE
-- Race: Beast-Warrior
-- Level 4
-- ATK 1100 | DEF 1400
-- Setcode: 121
--
-- Effect Text:
-- 把这张卡作为同调素材的场合，不是炎属性怪兽的同调召唤不能使用。这张卡被战斗破坏送去墓地时，可以从卡组把「孤炎星-鲁猪深」以外的1只名字带有「炎星」的4星怪兽特殊召唤。1回合1次，这张卡在场上存在的场合
-- 名字带有「炎星」的怪兽从自己的额外卡组特殊召唤时，可以从卡组选1张名字带有「炎舞」的魔法卡在自己场上盖放。
--[[ __CARD_HEADER_END__ ]]

--孤炎星－ロシシン
function c66762372.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(66762372,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c66762372.spcon)
	e1:SetTarget(c66762372.sptg)
	e1:SetOperation(c66762372.spop)
	c:RegisterEffect(e1)
	--set
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(66762372,1))
	e2:SetCategory(CATEGORY_SSET)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c66762372.setcon)
	e2:SetTarget(c66762372.settg)
	e2:SetOperation(c66762372.setop)
	c:RegisterEffect(e2)
	--synlimit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetValue(c66762372.synlimit)
	c:RegisterEffect(e3)
end
function c66762372.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c66762372.spfilter(c,e,tp)
	return c:IsSetCard(0x79) and c:IsLevel(4) and not c:IsCode(66762372) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c66762372.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c66762372.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c66762372.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c66762372.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c66762372.cfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x79) and c:IsSummonLocation(LOCATION_EXTRA) and c:IsPreviousControler(tp)
end
function c66762372.setcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c66762372.cfilter,1,nil,tp)
end
function c66762372.filter(c)
	return c:IsSetCard(0x7c) and c:IsType(TYPE_SPELL) and c:IsSSetable()
end
function c66762372.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c66762372.filter,tp,LOCATION_DECK,0,1,nil) end
end
function c66762372.setop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c66762372.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SSet(tp,g:GetFirst())
	end
end
function c66762372.synlimit(e,c)
	if not c then return false end
	return not c:IsAttribute(ATTRIBUTE_FIRE)
end
