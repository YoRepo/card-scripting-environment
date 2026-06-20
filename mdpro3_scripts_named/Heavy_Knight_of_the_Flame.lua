--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 业火之重骑士  (ID: 34761062)
-- Type: Monster / Effect / Gemini
-- Attribute: FIRE
-- Race: Zombie
-- Level 4
-- ATK 1800 | DEF 200
--
-- Effect Text:
-- ①：这张卡只要在场上·墓地存在，当作通常怪兽使用。
-- ②：可以把场上的当作通常怪兽使用的这张卡作为通常召唤作再1次召唤。那个场合这张卡变成当作效果怪兽使用并得到以下效果。
-- ●这张卡向特殊召唤的怪兽攻击的伤害步骤开始时才能发动。那只怪兽除外。
--[[ __CARD_HEADER_END__ ]]

--業火の重騎士
function c34761062.initial_effect(c)
	aux.EnableDualAttribute(c)
	--remove
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(34761062,0))
	e4:SetCategory(CATEGORY_REMOVE)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_BATTLE_START)
	e4:SetCondition(c34761062.descon)
	e4:SetTarget(c34761062.destg)
	e4:SetOperation(c34761062.desop)
	c:RegisterEffect(e4)
end
function c34761062.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c:IsDualState() and Duel.GetAttacker()==c
		and bc and bc:IsSummonType(SUMMON_TYPE_SPECIAL) and bc:IsAbleToRemove()
end
function c34761062.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,e:GetHandler():GetBattleTarget(),1,0,0)
end
function c34761062.desop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	if bc:IsRelateToBattle() then
		Duel.Remove(bc,POS_FACEUP,REASON_EFFECT)
	end
end
