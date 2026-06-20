--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 彼岸的恶鬼 齐里亚托  (ID: 57143342)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 3
-- ATK 1600 | DEF 1200
-- Setcode: 177
--
-- Effect Text:
-- 这个卡名的①③的效果1回合只能有1次使用其中任意1个。
-- ①：自己场上没有魔法·陷阱卡存在的场合才能发动。这张卡从手卡特殊召唤。
-- ②：自己场上有「彼岸」怪兽以外的怪兽存在的场合这张卡破坏。
-- ③：这张卡被送去墓地的场合，以「彼岸的恶鬼 齐里亚托」以外的自己墓地1只「彼岸」怪兽为对象才能发动。那只怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--彼岸の悪鬼 ガトルホッグ
function c57143342.initial_effect(c)
	--self destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_SELF_DESTROY)
	e1:SetCondition(c57143342.sdcon)
	c:RegisterEffect(e1)
	--Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(57143342,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,57143342)
	e2:SetCondition(c57143342.sscon)
	e2:SetTarget(c57143342.sstg)
	e2:SetOperation(c57143342.ssop)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(57143342,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCountLimit(1,57143342)
	e3:SetTarget(c57143342.sptg)
	e3:SetOperation(c57143342.spop)
	c:RegisterEffect(e3)
end
function c57143342.sdfilter(c)
	return c:IsFacedown() or not c:IsSetCard(0xb1)
end
function c57143342.sdcon(e)
	return Duel.IsExistingMatchingCard(c57143342.sdfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c57143342.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c57143342.sscon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c57143342.filter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c57143342.sstg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c57143342.ssop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c57143342.spfilter(c,e,tp)
	return c:IsSetCard(0xb1) and not c:IsCode(57143342) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c57143342.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c57143342.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c57143342.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c57143342.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c57143342.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
