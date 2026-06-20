--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 鹰身女妖的宠物幻龙  (ID: 85909450)
-- Type: Monster / Effect / Xyz
-- Attribute: WIND
-- Race: Dragon
-- Rank 4
-- ATK 2000 | DEF 2500
-- Setcode: 100
--
-- Effect Text:
-- 风属性4星怪兽×3
-- 这张卡的效果若这张卡的超量素材没有则不适用。这张卡可以直接攻击对方玩家。只要这张卡在场上表侧表示存在，对方不能把名字带有「鹰身」的怪兽作为攻击对象，也不能作为卡的效果的对象。每次自己的结束阶段把这张卡
-- 1个超量素材取除。
--[[ __CARD_HEADER_END__ ]]

--ハーピィズペット幻竜
function c85909450.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_WIND),4,3)
	c:EnableReviveLimit()
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c85909450.effcon)
	c:RegisterEffect(e1)
	--cannot be target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetCondition(c85909450.effcon)
	e2:SetValue(c85909450.atlimit)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetProperty(EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c85909450.efftg)
	e3:SetCondition(c85909450.effcon)
	e3:SetValue(aux.tgoval)
	c:RegisterEffect(e3)
	--remove material
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(85909450,0))
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c85909450.rmcon)
	e4:SetOperation(c85909450.rmop)
	c:RegisterEffect(e4)
end
function c85909450.effcon(e)
	return e:GetHandler():GetOverlayCount()>0
end
function c85909450.efftg(e,c)
	return c:IsSetCard(0x64) and c:IsType(TYPE_MONSTER)
end
function c85909450.atlimit(e,c)
	return c:IsFaceup() and c:IsSetCard(0x64)
end
function c85909450.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c85909450.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetOverlayCount()>0 then
		c:RemoveOverlayCard(tp,1,1,REASON_EFFECT)
	end
end
