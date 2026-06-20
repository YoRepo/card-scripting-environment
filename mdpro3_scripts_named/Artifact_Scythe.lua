--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 古遗物-死镰  (ID: 20292186)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 5
-- ATK 2200 | DEF 900
-- Setcode: 151
--
-- Effect Text:
-- ①：这张卡可以当作魔法卡使用从手卡到魔法与陷阱区域盖放。
-- ②：魔法与陷阱区域盖放的这张卡在对方回合被破坏送去墓地的场合发动。这张卡特殊召唤。
-- ③：对方回合，这张卡特殊召唤成功的场合发动。这个回合，对方不能从额外卡组把怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--アーティファクト－デスサイズ
function c20292186.initial_effect(c)
	--set
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MONSTER_SSET)
	e1:SetValue(TYPE_SPELL)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20292186,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c20292186.spcon)
	e2:SetTarget(c20292186.sptg)
	e2:SetOperation(c20292186.spop)
	c:RegisterEffect(e2)
	--cannot spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(20292186,1))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c20292186.dcon)
	e3:SetOperation(c20292186.dop)
	c:RegisterEffect(e3)
end
function c20292186.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_SZONE) and c:IsPreviousPosition(POS_FACEDOWN)
		and c:IsPreviousControler(tp)
		and c:IsReason(REASON_DESTROY) and Duel.GetTurnPlayer()~=tp
end
function c20292186.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c20292186.spop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
function c20292186.dcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c20292186.dop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(0,1)
	e1:SetTarget(c20292186.sumlimit)
	Duel.RegisterEffect(e1,tp)
end
function c20292186.sumlimit(e,c,sump,sumtype,sumpos,targetp,se)
	return c:IsLocation(LOCATION_EXTRA)
end
