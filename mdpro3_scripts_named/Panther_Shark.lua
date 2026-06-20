--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 豹鲨  (ID: 70101178)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level 5
-- ATK 1100 | DEF 2000
-- Setcode: 440
--
-- Effect Text:
-- 对方场上的怪兽是2只以上的场合，这张卡可以不用解放作召唤。此外，自己场上有「鹰鲨」存在的场合，这张卡可以从手卡特殊召唤。「豹鲨」在自己场上只能有1只表侧表示存在。
--[[ __CARD_HEADER_END__ ]]

--パンサー・シャーク
function c70101178.initial_effect(c)
	c:SetUniqueOnField(1,0,70101178)
	--summon with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(70101178,0))
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c70101178.ntcon)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_HAND)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetCondition(c70101178.spcon)
	c:RegisterEffect(e2)
end
function c70101178.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:IsLevelAbove(5) and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_MZONE)>1
end
function c70101178.filter(c)
	return c:IsFaceup() and c:IsCode(7500772)
end
function c70101178.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c70101178.filter,c:GetControler(),LOCATION_ONFIELD,0,1,nil)
end
