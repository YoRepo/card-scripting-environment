--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 格鲁斯异虫  (ID: 85754829)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Reptile
-- Level 4
-- ATK 1500 | DEF 300
-- Setcode: 62
--
-- Effect Text:
-- 每次场上里侧守备表示存在的怪兽反转，给这张卡放置1个虫指示物。这张卡放置的虫指示物每有1个，这张卡的攻击力上升300。
--[[ __CARD_HEADER_END__ ]]

--ワーム・グルス
function c85754829.initial_effect(c)
	c:EnableCounterPermit(0xf)
	--add counter
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHANGE_POS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c85754829.accon)
	e1:SetOperation(c85754829.acop)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c85754829.atkval)
	c:RegisterEffect(e2)
end
function c85754829.atkval(e,c)
	return c:GetCounter(0xf)*300
end
function c85754829.cfilter(c)
	return c:IsPreviousPosition(POS_FACEDOWN) and c:IsFaceup()
end
function c85754829.accon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c85754829.cfilter,1,e:GetHandler())
end
function c85754829.acop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(0xf,1)
end
