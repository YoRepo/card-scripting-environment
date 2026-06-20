--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 空牙团的修炼  (ID: 37890974)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
-- Setcode: 276
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：自己场上的「空牙团」怪兽被战斗或者对方的效果破坏的场合，以那1只怪兽为对象才能发动。从卡组把持有比那只怪兽的原本等级低的等级的1只「空牙团」怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--空牙団の修練
function c37890974.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(37890974,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,37890974)
	e2:SetTarget(c37890974.sptg)
	e2:SetOperation(c37890974.spop)
	c:RegisterEffect(e2)
end
function c37890974.spfilter1(c,e,tp,rp)
	local lv=c:GetLevel()
	return (c:IsReason(REASON_BATTLE) or (rp==1-tp and c:IsReason(REASON_EFFECT)))
		and c:IsPreviousSetCard(0x114) and c:IsType(TYPE_MONSTER)
		and c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousControler(tp)
		and c:IsLocation(LOCATION_GRAVE+LOCATION_REMOVED) and c:IsCanBeEffectTarget(e)
		and lv>0 and Duel.IsExistingMatchingCard(c37890974.spfilter2,tp,LOCATION_DECK,0,1,nil,e,tp,lv)
end
function c37890974.spfilter2(c,e,tp,lv)
	return c:GetLevel()<lv and c:IsSetCard(0x114) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c37890974.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return eg:IsContains(chkc) and c37890974.spfilter1(chkc,e,tp,rp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and eg:IsExists(c37890974.spfilter1,1,nil,e,tp,rp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=eg:FilterSelect(tp,c37890974.spfilter1,1,1,nil,e,tp,rp)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c37890974.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not tc:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c37890974.spfilter2,tp,LOCATION_DECK,0,1,1,nil,e,tp,tc:GetLevel())
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
