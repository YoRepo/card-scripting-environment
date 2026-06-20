--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 双天之狮使-阿吽  (ID: 28798938)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Warrior
-- Level 4
-- ATK 0 | DEF 0
-- Setcode: 335
--
-- Effect Text:
-- 「双天」怪兽×2
-- ①：这张卡得到作为融合素材的怪兽的原本卡名的以下效果。
-- ●「双天将 金刚」：进行战斗的自己的「双天」怪兽的攻击力只在伤害计算时变成3000。
-- ●「双天将 密迹」：对方回合1次，以场上1张卡为对象才能发动。那张卡除外。
-- ②：融合召唤的这张卡被破坏的场合才能发动。从卡组把「双天拳之熊罴」「双天脚之鸿鹄」各1只特殊召唤。那些怪兽在这个回合不会被战斗·效果破坏。
--[[ __CARD_HEADER_END__ ]]

--双天の獅使－阿吽
function c28798938.initial_effect(c)
	--fusion summon
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x14f),2,true)
	--effect gain
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EVENT_SPSUMMON_SUCCESS)
	e0:SetCondition(c28798938.regcon)
	e0:SetOperation(c28798938.regop)
	c:RegisterEffect(e0)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCondition(c28798938.spcon)
	e3:SetTarget(c28798938.sptg)
	e3:SetOperation(c28798938.spop)
	c:RegisterEffect(e3)
end
function c28798938.regcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function c28798938.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=c:GetMaterial()
	if #g==0 then return end
	if g:IsExists(Card.IsType,1,nil,TYPE_EFFECT) then
		c:RegisterFlagEffect(85360035,RESET_EVENT+RESETS_STANDARD,0,1)
	end
	if g:IsExists(Card.IsOriginalCodeRule,1,nil,33026283) then
		--atk down
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetRange(LOCATION_MZONE)
		e1:SetTargetRange(LOCATION_MZONE,0)
		e1:SetCondition(c28798938.atkcon)
		e1:SetTarget(c28798938.atktg)
		e1:SetValue(3000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1)
		c:RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(28798938,0))
	end
	if g:IsExists(Card.IsOriginalCodeRule,1,nil,284224) then
		--remove
		local e2=Effect.CreateEffect(c)
		e2:SetDescription(aux.Stringid(28798938,2))
		e2:SetCategory(CATEGORY_REMOVE)
		e2:SetType(EFFECT_TYPE_QUICK_O)
		e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e2:SetCode(EVENT_FREE_CHAIN)
		e2:SetRange(LOCATION_MZONE)
		e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
		e2:SetCountLimit(1)
		e2:SetCondition(c28798938.rmcon)
		e2:SetTarget(c28798938.rmtg)
		e2:SetOperation(c28798938.rmop)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e2)
		c:RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(28798938,1))
	end
end
function c28798938.atkcon(e)
	local tp=e:GetHandlerPlayer()
	local a=Duel.GetBattleMonster(tp)
	return Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL and a and a:IsSetCard(0x14f)
end
function c28798938.atktg(e,c)
	local tp=e:GetHandlerPlayer()
	local a=Duel.GetBattleMonster(tp)
	return c==a
end
function c28798938.rmcon(e)
	return Duel.GetTurnPlayer()~=e:GetHandlerPlayer()
end
function c28798938.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c28798938.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
function c28798938.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsSummonType(SUMMON_TYPE_FUSION)
end
function c28798938.spfilter(c,e,tp)
	return c:IsCode(85360035,11759079) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c28798938.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		if ft<2 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return false end
		local g=Duel.GetMatchingGroup(c28798938.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
		return g:CheckSubGroup(aux.dncheck,2,2)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_DECK)
end
function c28798938.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<2 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local g=Duel.GetMatchingGroup(c28798938.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=g:SelectSubGroup(tp,aux.dncheck,false,2,2)
	if not sg then return end
	local tc=sg:GetFirst()
	for tc in aux.Next(sg) do
		if Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
			e1:SetValue(1)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
			e2:SetValue(1)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e2)
			tc:RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(28798938,3))
		end
	end
	Duel.SpecialSummonComplete()
end
