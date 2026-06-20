--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 转生炎兽 独角兔  (ID: 60303245)
-- Type: Monster / Effect / Link
-- Attribute: FIRE
-- Race: Cyberse
-- ATK 0 | LINK
-- Setcode: 281
--
-- Effect Text:
-- 通常召唤的攻击力1000以下的怪兽1只
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：自己·对方回合，把这张卡解放，以自己场上1只怪兽为对象才能发动。这个回合，那只怪兽不会被对方的效果破坏。
-- ②：这张卡在墓地存在的状态，通常召唤的自己怪兽被战斗破坏时才能发动。这张卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--転生炎獣アルミラージ
function c60303245.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c60303245.matfilter,1,1)
	--immunity
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(60303245,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c60303245.immcost)
	e1:SetTarget(c60303245.immtg)
	e1:SetOperation(c60303245.immop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,60303245)
	e2:SetCondition(c60303245.spcon)
	e2:SetTarget(c60303245.sptg)
	e2:SetOperation(c60303245.spop)
	c:RegisterEffect(e2)
end
function c60303245.matfilter(c)
	return c:IsSummonType(SUMMON_TYPE_NORMAL) and c:IsAttackBelow(1000)
end
function c60303245.immcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReleasable() end
	Duel.Release(c,REASON_COST)
end
function c60303245.immtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_MZONE,0,1,1,nil)
end
function c60303245.immop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		e1:SetValue(aux.indoval)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c60303245.spcfilter(c,tp)
	return c:IsSummonType(SUMMON_TYPE_NORMAL) and c:IsPreviousControler(tp)
end
function c60303245.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c60303245.spcfilter,1,nil,tp)
end
function c60303245.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c60303245.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
