--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 冥界龙 龙亡  (ID: 8198620)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Dragon
-- Level 8
-- ATK 3000 | DEF 0
--
-- Effect Text:
-- 不死族怪兽×2
-- 这张卡用融合召唤才能从额外卡组特殊召唤。
-- ①：「冥界龙 龙亡」在自己场上只能有1只表侧表示存在。
-- ②：和这张卡进行战斗的怪兽不会被那次战斗破坏。
-- ③：这张卡和怪兽进行战斗的伤害步骤结束时发动。那只怪兽的攻击力变成0，把持有和那只怪兽的原本的等级·攻击力相同等级·攻击力的1只「暗魂体衍生物」（不死族·暗·攻?/守0）在自己场上特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--冥界龍 ドラゴネクロ
function c8198620.initial_effect(c)
	c:SetUniqueOnField(1,0,8198620)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsRace,RACE_ZOMBIE),2,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)
	--battle
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(8198620,0))
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetCondition(aux.dsercon)
	e2:SetTarget(c8198620.attg)
	e2:SetOperation(c8198620.atop)
	c:RegisterEffect(e2)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetTarget(c8198620.indestg)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c8198620.attg(e,tp,eg,ep,ev,re,r,rp,chk)
	local bc=e:GetHandler():GetBattleTarget()
	if chk==0 then return bc and bc:IsRelateToBattle() end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c8198620.atop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if bc:IsRelateToBattle() and bc:IsFaceup() then
		local lv=bc:GetOriginalLevel()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		bc:RegisterEffect(e1)
		if lv>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and Duel.IsPlayerCanSpecialSummonMonster(tp,8198621,0,TYPES_TOKEN_MONSTER,-2,0,0,RACE_ZOMBIE,ATTRIBUTE_DARK) then
			local token=Duel.CreateToken(tp,8198621)
			local atk=bc:GetBaseAttack()
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_ATTACK)
			e1:SetValue(atk)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD)
			token:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_CHANGE_LEVEL)
			e2:SetValue(lv)
			token:RegisterEffect(e2)
			Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
function c8198620.indestg(e,c)
	return c==e:GetHandler():GetBattleTarget()
end
