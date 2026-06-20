--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 烙印的使徒  (ID: 34536828)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 349
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：对方发动的怪兽的效果处理时，自己场上有8星以上的恶魔族融合怪兽存在，那只对方怪兽的攻击力或者守备力是0的场合，可以把那个发动的效果无效。
-- ②：攻击力0的怪兽之间进行战斗的伤害步骤结束时才能发动。那只进行战斗的对方怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--烙印の使徒
function c34536828.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVING)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c34536828.disop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_DAMAGE_STEP_END)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1,34536828)
	e3:SetCondition(c34536828.descon)
	e3:SetOperation(c34536828.desop)
	c:RegisterEffect(e3)
end
function c34536828.disfilter(c)
	return c:IsType(TYPE_FUSION) and c:IsRace(RACE_FIEND) and c:IsLevelAbove(8) and c:IsFaceup()
end
function c34536828.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=re:GetHandler()
	if rp==1-tp and Duel.IsChainDisablable(ev) and c:GetFlagEffect(34536828)==0 and re:IsActiveType(TYPE_MONSTER)
		and (rc:IsFaceup() and rc:IsLocation(LOCATION_MZONE) and (rc:IsAttack(0) or rc:IsDefense(0))
			or not (rc:IsFaceup() and rc:IsLocation(LOCATION_MZONE)) and (rc:GetTextAttack()==0 or not rc:IsType(TYPE_LINK) and rc:GetTextDefense()==0))
		and Duel.IsExistingMatchingCard(c34536828.disfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.SelectEffectYesNo(tp,c,aux.Stringid(34536828,0)) then
		Duel.Hint(HINT_CARD,0,34536828)
		Duel.NegateEffect(ev)
		c:RegisterFlagEffect(34536828,RESET_PHASE+PHASE_END,0,0)
	end
end
function c34536828.descon(e,tp,eg,ep,ev,re,r,rp)
	local a,d=Duel.GetBattleMonster(tp)
	return a and d and a:IsAttack(0) and d:IsAttack(0) and d:IsRelateToBattle()
end
function c34536828.desop(e,tp,eg,ep,ev,re,r,rp)
	local a,d=Duel.GetBattleMonster(tp)
	if d and d:IsRelateToBattle() then
		Duel.Destroy(d,REASON_EFFECT)
	end
end
