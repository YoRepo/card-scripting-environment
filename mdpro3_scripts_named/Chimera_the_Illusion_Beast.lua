--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 幻想魔兽 奇美拉  (ID: 38264974)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Illusion
-- Level 8
-- ATK 3100 | DEF 2800
--
-- Effect Text:
-- 「有翼幻兽 奇美拉」＋幻想魔族怪兽1只以上
-- ①：这张卡的卡名只要在场上·墓地存在当作「有翼幻兽 奇美拉」使用。
-- ②：这张卡在同1次的战斗阶段中可以向怪兽作出最多有作为这张卡的融合素材的怪兽数量的攻击。
-- ③：这张卡和怪兽进行战斗的场合，那2只不会被那次战斗破坏。
-- ④：这张卡和对方怪兽进行战斗的伤害步骤结束时才能发动。那只对方怪兽的攻击力变成0，效果无效化。
--[[ __CARD_HEADER_END__ ]]

--幻想魔獣キマイラ
local s,id,o=GetID()
function s.initial_effect(c)
	c:EnableReviveLimit()
	--material
	aux.AddFusionProcCodeFunRep(c,4796100,aux.FilterBoolFunction(Card.IsRace,RACE_ILLUSION),1,127,true,true)
	--change name
	aux.EnableChangeCode(c,4796100,LOCATION_GRAVE+LOCATION_MZONE)
	--multi-attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK_MONSTER)
	e1:SetValue(s.atkct)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(s.indtg)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--disable
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,0))
	e3:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DISABLE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_DAMAGE_STEP_END)
	e3:SetCondition(aux.dsercon)
	e3:SetTarget(s.target)
	e3:SetOperation(s.operation)
	c:RegisterEffect(e3)
end
function s.indtg(e,c)
	local tc=e:GetHandler()
	return c==tc or c==tc:GetBattleTarget()
end
function s.atkct(e,c)
	return c:IsSummonType(SUMMON_TYPE_FUSION) and c:GetMaterialCount()-1 or 0
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local bc=e:GetHandler():GetBattleTarget()
	if chk==0 then return bc and bc:IsRelateToBattle() and (aux.nzatk(bc) or aux.NegateMonsterFilter(bc)) end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,bc,1,0,0)
end
function s.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if bc:IsRelateToBattle() and bc:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		bc:RegisterEffect(e1)
		Duel.NegateRelatedChain(bc,RESET_TURN_SET)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		bc:RegisterEffect(e2)
		local e3=e2:Clone()
		e3:SetCode(EFFECT_DISABLE_EFFECT)
		e3:SetValue(RESET_TURN_SET)
		bc:RegisterEffect(e3)
	end
end
