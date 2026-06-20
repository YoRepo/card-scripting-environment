--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 邪心英雄 恶刃魔  (ID: 58554959)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Fiend
-- Level 7
-- ATK 2600 | DEF 1800
-- Setcode: 24584
--
-- Effect Text:
-- 对方场上有怪兽存在的场合，这张卡可以把1只怪兽解放表侧表示上级召唤。
-- ①：这张卡向守备表示怪兽攻击的场合，给与攻击力超过那个守备力的数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--E-HERO マリシャス・エッジ
function c58554959.initial_effect(c)
	--summon with 1 tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(58554959,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c58554959.otcon)
	e1:SetOperation(c58554959.otop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
end
function c58554959.otcon(e,c,minc)
	if c==nil then return true end
	return Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_MZONE)>0
		and c:IsLevelAbove(7) and minc<=1 and Duel.CheckTribute(c,1)
end
function c58554959.otop(e,tp,eg,ep,ev,re,r,rp,c)
	local sg=Duel.SelectTribute(tp,c,1,1)
	c:SetMaterial(sg)
	Duel.Release(sg,REASON_SUMMON+REASON_MATERIAL)
end
