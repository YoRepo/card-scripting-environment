--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 电子光虫-比特蜈蚣  (ID: 68950538)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Insect
-- Level 3
-- ATK 1500 | DEF 500
--
-- Effect Text:
-- 把这张卡作为超量召唤的素材的场合，不是昆虫族怪兽的超量召唤不能使用。
-- ①：1回合1次，表侧攻击表示的这张卡变成守备表示时才能发动。从卡组把1只昆虫族·3星怪兽守备表示特殊召唤。
-- ②：场上的这张卡为素材作超量召唤的怪兽得到以下效果。
-- ●这张卡可以向对方场上的全部守备表示怪兽各作1次攻击。
--[[ __CARD_HEADER_END__ ]]

--電子光虫－センチビット
function c68950538.initial_effect(c)
	--xyzlimit
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetValue(c68950538.xyzlimit)
	c:RegisterEffect(e0)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(68950538,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_CHANGE_POS)
	e1:SetCountLimit(1)
	e1:SetCondition(c68950538.spcon)
	e1:SetTarget(c68950538.sptg)
	e1:SetOperation(c68950538.spop)
	c:RegisterEffect(e1)
	--effect gain
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetProperty(EFFECT_FLAG_EVENT_PLAYER)
	e2:SetCondition(c68950538.efcon)
	e2:SetOperation(c68950538.efop)
	c:RegisterEffect(e2)
end
function c68950538.xyzlimit(e,c)
	if not c then return false end
	return not c:IsRace(RACE_INSECT)
end
function c68950538.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return not c:IsStatus(STATUS_CONTINUOUS_POS) and c:IsPosition(POS_FACEUP_DEFENSE) and c:IsPreviousPosition(POS_FACEUP_ATTACK)
end
function c68950538.spfilter(c,e,tp)
	return c:IsLevel(3) and c:IsRace(RACE_INSECT) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c68950538.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c68950538.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c68950538.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c68950538.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
function c68950538.efcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_XYZ
end
function c68950538.efop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=c:GetReasonCard()
	local e1=Effect.CreateEffect(rc)
	e1:SetDescription(aux.Stringid(68950538,1))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e1:SetCode(EFFECT_ATTACK_ALL)
	e1:SetValue(c68950538.atkfilter)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	rc:RegisterEffect(e1,true)
	if not rc:IsType(TYPE_EFFECT) then
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_ADD_TYPE)
		e2:SetValue(TYPE_EFFECT)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		rc:RegisterEffect(e2,true)
	end
end
function c68950538.atkfilter(e,c)
	return c:IsPosition(POS_DEFENSE)
end
