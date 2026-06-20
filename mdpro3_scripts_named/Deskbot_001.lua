--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 文具电子人001  (ID: 94693857)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Machine
-- Level 1
-- ATK 500 | DEF 500
-- Setcode: 171
--
-- Effect Text:
-- ①：这张卡的攻击力·守备力上升自己场上的机械族怪兽数量×500。
-- ②：这张卡在墓地存在，场上有机械族怪兽2只以上同时特殊召唤的场合才能发动。这张卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ブンボーグ001
function c94693857.initial_effect(c)
	--same effect send this card to grave and summon another card check
	local e0=aux.AddThisCardInGraveAlreadyCheck(c)
	--atk/def
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c94693857.atkval)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(94693857,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCountLimit(1,EFFECT_COUNT_CODE_CHAIN)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetLabelObject(e0)
	e3:SetCondition(c94693857.spcon)
	e3:SetTarget(c94693857.sptg)
	e3:SetOperation(c94693857.spop)
	c:RegisterEffect(e3)
end
function c94693857.filter(c,se)
	return c:IsFaceup() and c:IsRace(RACE_MACHINE) and (se==nil or c:GetReasonEffect()~=se)
end
function c94693857.atkval(e,c)
	return Duel.GetMatchingGroupCount(c94693857.filter,c:GetControler(),LOCATION_MZONE,0,nil)*500
end
function c94693857.spcon(e,tp,eg,ep,ev,re,r,rp)
	local se=e:GetLabelObject():GetLabelObject()
	return eg:IsExists(c94693857.filter,2,nil,se)
end
function c94693857.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c94693857.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
