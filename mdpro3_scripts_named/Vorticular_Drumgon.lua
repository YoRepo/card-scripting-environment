--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 弹鼓龙  (ID: 739444)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Dragon
-- ATK 1000 | LINK
--
-- Effect Text:
-- 龙族·暗属性怪兽3只
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡特殊召唤成功的场合才能发动。自己从卡组抽1张。
-- ②：这张卡的①的效果适用的回合只要这张卡在怪兽区域存在，作为这张卡所连接区的没有使用的怪兽区域不能使用。
--[[ __CARD_HEADER_END__ ]]

--マガジンドラムゴン
function c739444.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c739444.matfilter,3,3)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(739444,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,739444)
	e1:SetTarget(c739444.drtg)
	e1:SetOperation(c739444.drop)
	c:RegisterEffect(e1)
	--disable field
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DISABLE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c739444.discon)
	e2:SetValue(c739444.disval)
	c:RegisterEffect(e2)
end
function c739444.matfilter(c)
	return c:IsLinkRace(RACE_DRAGON) and c:IsLinkAttribute(ATTRIBUTE_DARK)
end
function c739444.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c739444.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
	e:GetHandler():RegisterFlagEffect(739444,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,0)
end
function c739444.discon(e)
	return e:GetHandler():GetFlagEffect(739444)~=0
end
function c739444.disval(e)
	local c=e:GetHandler()
	return c:GetLinkedZone(0)
end
