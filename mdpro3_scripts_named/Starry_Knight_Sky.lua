--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 辉煌的圣夜  (ID: 58406094)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 345
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：只要这张卡在场地区域存在，自己在通常召唤外加上只有1次，自己主要阶段可以把1只「圣夜骑士」怪兽或者龙族·光属性·7星怪兽召唤。
-- ②：自己回合，自己场上的表侧表示的龙族·光属性·7星怪兽回到手卡的场合才能发动。自己从卡组抽1张。
--[[ __CARD_HEADER_END__ ]]

--煌めく聖夜
function c58406094.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--extra summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(58406094,0))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e2:SetTarget(c58406094.extg)
	c:RegisterEffect(e2)
	--draw
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_TO_HAND)
	e3:SetRange(LOCATION_FZONE)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCountLimit(1,58406094)
	e3:SetCondition(c58406094.drcon)
	e3:SetTarget(c58406094.drtg)
	e3:SetOperation(c58406094.drop)
	c:RegisterEffect(e3)
end
function c58406094.extg(e,c)
	return c:IsSetCard(0x159) or (c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsRace(RACE_DRAGON) and c:IsLevel(7))
end
function c58406094.cfilter(c,tp)
	return c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE) and c:IsRace(RACE_DRAGON) and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsLevel(7) and c:IsPreviousPosition(POS_FACEUP)
end
function c58406094.drcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c58406094.cfilter,1,nil,tp) and Duel.GetTurnPlayer()==tp
end
function c58406094.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c58406094.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
