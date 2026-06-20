--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 古遗物-勇士盾  (ID: 11475049)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 5
-- ATK 1500 | DEF 2200
-- Setcode: 151
--
-- Effect Text:
-- 这张卡可以当作魔法卡使用从手卡到魔法与陷阱卡区域盖放。魔法与陷阱卡区域盖放的这张卡在对方回合被破坏送去墓地时，这张卡特殊召唤。对方回合中这张卡特殊召唤成功的场合，这个回合对方不能把自己场上的名字带有「
-- 古遗物」的怪兽作为攻击对象。
--[[ __CARD_HEADER_END__ ]]

--アーティファクト－アキレウス
function c11475049.initial_effect(c)
	--set
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MONSTER_SSET)
	e1:SetValue(TYPE_SPELL)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(11475049,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c11475049.spcon)
	e2:SetTarget(c11475049.sptg)
	e2:SetOperation(c11475049.spop)
	c:RegisterEffect(e2)
	--cannot be battle target
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(11475049,1))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c11475049.atcon)
	e3:SetOperation(c11475049.atop)
	c:RegisterEffect(e3)
end
function c11475049.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_SZONE) and c:IsPreviousPosition(POS_FACEDOWN)
		and c:IsPreviousControler(tp)
		and c:IsReason(REASON_DESTROY) and Duel.GetTurnPlayer()~=tp
end
function c11475049.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c11475049.spop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
function c11475049.atcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c11475049.atop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(c11475049.atlimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c11475049.atlimit(e,c)
	return c:IsFaceup() and c:IsSetCard(0x97)
end
