--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 地狱大百足  (ID: 36029076)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Insect
-- Level 7
-- ATK 2600 | DEF 1300
--
-- Effect Text:
-- 对方场上有怪兽存在，自己场上没有怪兽存在的场合，这张卡可以不用解放作召唤。这个方法召唤的这张卡的原本攻击力变成1300。
--[[ __CARD_HEADER_END__ ]]

--地獄大百足
function c36029076.initial_effect(c)
	--summon with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(36029076,0))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c36029076.ntcon)
	e1:SetOperation(c36029076.ntop)
	c:RegisterEffect(e1)
end
function c36029076.ntcon(e,c,minc)
	if c==nil then return true end
	local tp=c:GetControler()
	return minc==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
		and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c36029076.ntop(e,tp,eg,ep,ev,re,r,rp,c)
	--change base attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetReset(RESET_EVENT+0xff0000)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetValue(1300)
	c:RegisterEffect(e1)
end
