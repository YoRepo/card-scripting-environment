--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 影六武众-风魔  (ID: 71207871)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Warrior
-- Level 1
-- ATK 200 | DEF 1800
-- Setcode: 36925
--
-- Effect Text:
-- ①：这张卡被战斗·效果破坏的场合才能发动。从卡组把「影六武众-风魔」以外的1只「六武众」怪兽特殊召唤。
-- ②：只让自己场上的「六武众」怪兽1只被效果破坏的场合，可以作为代替把墓地的这张卡除外。
--[[ __CARD_HEADER_END__ ]]

--影六武衆－フウマ
function c71207871.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(71207871,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetCondition(c71207871.spcon)
	e1:SetTarget(c71207871.sptg)
	e1:SetOperation(c71207871.spop)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetTarget(c71207871.reptg)
	e2:SetValue(c71207871.repval)
	e2:SetOperation(c71207871.repop)
	c:RegisterEffect(e2)
end
function c71207871.spcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT+REASON_BATTLE)~=0
end
function c71207871.spfilter(c,e,tp)
	return c:IsSetCard(0x103d) and not c:IsCode(71207871) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c71207871.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c71207871.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c71207871.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tg=Duel.SelectMatchingCard(tp,c71207871.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp):GetFirst()
	if tg then
		Duel.SpecialSummon(tg,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c71207871.repfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x103d)
		and c:IsLocation(LOCATION_MZONE) and c:IsControler(tp) and c:IsReason(REASON_EFFECT) and not c:IsReason(REASON_REPLACE)
end
function c71207871.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() and eg:IsExists(c71207871.repfilter,1,nil,tp)
	and eg:GetCount()==1
	end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function c71207871.repval(e,c)
	return c71207871.repfilter(c,e:GetHandlerPlayer())
end
function c71207871.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
end
