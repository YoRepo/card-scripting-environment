--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 军贯处『海栈』  (ID: 62200831)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 358
--
-- Effect Text:
-- ①：1回合1次，自己对「军贯」怪兽的召唤·特殊召唤成功的场合才能发动（伤害步骤也能发动）。从卡组选1张「军贯」卡在卡组最上面放置。
-- ②：1回合1次，从额外卡组特殊召唤的自己场上的「军贯」怪兽被对方送去墓地的场合发动。对方支付那个守备力数值的基本分。那之后，自己可以让以下效果适用。
-- ●手卡1只「舍利军贯」特殊召唤，把1只「军贯」超量怪兽在那上面重叠当作超量召唤从额外卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--軍貫処 『海せん』
function c62200831.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--to deck top
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(62200831,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e2:SetCondition(c62200831.dtcon)
	e2:SetTarget(c62200831.dttg)
	e2:SetOperation(c62200831.dtop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--pay and spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(62200831,2))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c62200831.spcon)
	e4:SetTarget(c62200831.sptg)
	e4:SetOperation(c62200831.spop)
	c:RegisterEffect(e4)
end
function c62200831.cfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x166) and c:IsSummonPlayer(tp)
end
function c62200831.dtcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c62200831.cfilter,1,nil,tp)
end
function c62200831.dttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>1
		and Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_DECK,0,1,nil,0x166) end
end
function c62200831.dtop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(62200831,1))
	local g=Duel.SelectMatchingCard(tp,Card.IsSetCard,tp,LOCATION_DECK,0,1,1,nil,0x166)
	local tc=g:GetFirst()
	if tc then
		Duel.ShuffleDeck(tp)
		Duel.MoveSequence(tc,SEQ_DECKTOP)
		Duel.ConfirmDecktop(tp,1)
	end
end
function c62200831.cfilter2(c,tp)
	return c:IsSummonLocation(LOCATION_EXTRA) and c:IsPreviousSetCard(0x166) and c:GetReasonPlayer()==1-tp
		and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousPosition(POS_FACEUP)
end
function c62200831.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c62200831.cfilter2,1,nil,tp)
end
function c62200831.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local tg=eg:Filter(c62200831.cfilter2,nil,tp)
	local def=tg:GetSum(Card.GetBaseDefense)
	e:SetLabel(def)
end
function c62200831.spfilter(c,e,tp)
	return c:IsCode(24639891) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.IsExistingMatchingCard(c62200831.xyzfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,c)
end
function c62200831.xyzfilter(c,e,tp,mc)
	return c:IsSetCard(0x166) and mc:IsCanBeXyzMaterial(c) and c:IsType(TYPE_XYZ)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
		and Duel.GetLocationCountFromEx(tp,tp,mc,c)>0
end
function c62200831.spop(e,tp,eg,ep,ev,re,r,rp)
	local def=e:GetLabel()
	if def==0 or def>Duel.GetLP(1-tp) then return end
	Duel.PayLPCost(1-tp,def)
	if Duel.IsPlayerCanSpecialSummonCount(tp,2)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and aux.MustMaterialCheck(nil,tp,EFFECT_MUST_BE_XMATERIAL)
		and Duel.IsExistingMatchingCard(c62200831.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp)
		and Duel.SelectYesNo(tp,aux.Stringid(62200831,3)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local g1=Duel.SelectMatchingCard(tp,c62200831.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
		Duel.SpecialSummon(g1,0,tp,tp,false,false,POS_FACEUP)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g2=Duel.SelectMatchingCard(tp,c62200831.xyzfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,g1:GetFirst())
		local tc=g2:GetFirst()
		tc:SetMaterial(g1)
		Duel.Overlay(tc,g1)
		Duel.SpecialSummon(tc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
