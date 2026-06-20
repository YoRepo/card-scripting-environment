--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 燃烧拳击手 第一助手  (ID: 47921178)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Warrior
-- Level 4
-- ATK 500 | DEF 2000
-- Setcode: 4228
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：对方怪兽的攻击宣言时，若自己场上有战士族怪兽或炎属性怪兽存在则能发动。这张卡从手卡特殊召唤，那次攻击无效。那之后，场上1只怪兽直到结束阶段除外。
-- ②：只要这张卡在怪兽区域存在，自己在通常召唤外加上只有1次，自己主要阶段可以把1只「燃烧拳击手」怪兽召唤。
--[[ __CARD_HEADER_END__ ]]

--BK チーフセコンド
function c47921178.initial_effect(c)
	--negate attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(47921178,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,47921178)
	e1:SetCondition(c47921178.spcon)
	e1:SetTarget(c47921178.sptg)
	e1:SetOperation(c47921178.spop)
	c:RegisterEffect(e1)
	--extra summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(47921178,1))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x1084))
	c:RegisterEffect(e2)
end
function c47921178.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp)
end
function c47921178.cfilter(c)
	return c:IsFaceup() and (c:IsRace(RACE_WARRIOR) or c:IsAttribute(ATTRIBUTE_FIRE))
end
function c47921178.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c47921178.cfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c47921178.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToChain() and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0
		and Duel.NegateAttack() then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
		local tc=g:GetFirst()
		if tc then
			Duel.BreakEffect()
			Duel.HintSelection(g)
			if Duel.Remove(tc,0,REASON_EFFECT+REASON_TEMPORARY)~=0 then
				tc:RegisterFlagEffect(47921178,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
				e1:SetCode(EVENT_PHASE+PHASE_END)
				e1:SetReset(RESET_PHASE+PHASE_END)
				e1:SetLabelObject(tc)
				e1:SetCountLimit(1)
				e1:SetCondition(c47921178.retcon)
				e1:SetOperation(c47921178.retop)
				Duel.RegisterEffect(e1,tp)
			end
		end
	end
end
function c47921178.retcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetLabelObject():GetFlagEffect(47921178)~=0
end
function c47921178.retop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ReturnToField(e:GetLabelObject())
end
