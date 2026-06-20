--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 超重武者 法螺贝-E  (ID: 64373401)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Machine
-- Level 2
-- ATK 300 | DEF 600
-- Setcode: 154
--
-- Effect Text:
-- ①：自己墓地没有魔法·陷阱卡存在的场合，这张卡可以从手卡特殊召唤。这个方法特殊召唤成功的回合，自己不是「超重武者」怪兽不能特殊召唤。
-- ②：自己墓地没有魔法·陷阱卡存在，把这张卡解放对「超重武者」怪兽的上级召唤成功的场合才能发动。这张卡从墓地特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--超重武者ホラガ－E
function c64373401.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c64373401.hspcon)
	e1:SetOperation(c64373401.hspop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(64373401,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetCondition(c64373401.spcon)
	e2:SetTarget(c64373401.sptg)
	e2:SetOperation(c64373401.spop)
	c:RegisterEffect(e2)
end
function c64373401.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c64373401.hspcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and not Duel.IsExistingMatchingCard(c64373401.filter,tp,LOCATION_GRAVE,0,1,nil)
end
function c64373401.hspop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c64373401.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c64373401.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0x9a)
end
function c64373401.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_GRAVE) and r==REASON_SUMMON and c:GetReasonCard():IsSetCard(0x9a)
		and not Duel.IsExistingMatchingCard(c64373401.filter,tp,LOCATION_GRAVE,0,1,nil)
end
function c64373401.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c64373401.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
