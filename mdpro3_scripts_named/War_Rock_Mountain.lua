--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 战吼的奇岩  (ID: 45943516)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 351
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：作为这张卡的发动时的效果处理，可以从卡组把1只「战吼」怪兽加入手卡。
-- ②：自己场上的怪兽不存在的场合或者只有战士族怪兽的场合，自己·对方的战斗阶段开始时才能发动。同名卡不在自己场上存在的1只「战吼」怪兽从手卡特殊召唤。
-- ③：自己的战士族怪兽被战斗破坏的场合，可以作为代替把这张卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--ザ・ロック・オブ・ウォークライ
function c45943516.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,45943516+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(c45943516.activate)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(45943516,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_BATTLE_START)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c45943516.spcon)
	e2:SetTarget(c45943516.sptg)
	e2:SetOperation(c45943516.spop)
	c:RegisterEffect(e2)
	--destroy replace
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetRange(LOCATION_FZONE)
	e3:SetTarget(c45943516.reptg)
	e3:SetValue(c45943516.repval)
	e3:SetOperation(c45943516.repop)
	c:RegisterEffect(e3)
end
function c45943516.thfilter(c)
	return c:IsSetCard(0x15f) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c45943516.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c45943516.thfilter,tp,LOCATION_DECK,0,nil)
	if #g>0 and Duel.SelectYesNo(tp,aux.Stringid(45943516,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
function c45943516.cfilter1(c)
	return c:IsFacedown() or not c:IsRace(RACE_WARRIOR)
end
function c45943516.spcon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c45943516.cfilter1,tp,LOCATION_MZONE,0,1,nil)
end
function c45943516.cfilter2(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c45943516.spfilter(c,e,tp)
	return c:IsSetCard(0x15f) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and not Duel.IsExistingMatchingCard(c45943516.cfilter2,tp,LOCATION_ONFIELD,0,1,nil,c:GetCode())
end
function c45943516.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c45943516.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c45943516.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c45943516.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c45943516.repfilter(c,tp)
	return c:IsFaceup() and c:IsLocation(LOCATION_MZONE) and c:IsRace(RACE_WARRIOR)
		and c:IsControler(tp) and c:IsReason(REASON_BATTLE) and not c:IsReason(REASON_REPLACE)
end
function c45943516.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGrave() and not c:IsStatus(STATUS_DESTROY_CONFIRMED)
		and eg:IsExists(c45943516.repfilter,1,nil,tp) end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function c45943516.repval(e,c)
	return c45943516.repfilter(c,e:GetHandlerPlayer())
end
function c45943516.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT+REASON_REPLACE)
end
