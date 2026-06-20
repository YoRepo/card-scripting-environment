--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 直播☆双子 姬丝基勒·霜精  (ID: 54257392)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Aqua
-- Level 2
-- ATK 500 | DEF 0
-- Setcode: 22155601
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次，②的效果1回合只能使用1次。
-- ①：自己场上有「璃拉」怪兽存在的场合，这张卡可以从手卡特殊召唤。
-- ②：对方用卡的效果从卡组把卡加入手卡的场合，若自己场上有「邪恶★双子」怪兽存在，把墓地的这张卡除外才能发动。自己抽1张。
--[[ __CARD_HEADER_END__ ]]

--Live☆Twin キスキル・フロスト
function c54257392.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(54257392,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,54257392+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c54257392.spcon)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(54257392,1))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_TO_HAND)
	e2:SetCountLimit(1,54257393)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCost(aux.bfgcost)
	e2:SetCondition(c54257392.drcon)
	e2:SetTarget(c54257392.drtg)
	e2:SetOperation(c54257392.drop)
	c:RegisterEffect(e2)
end
function c54257392.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x153)
end
function c54257392.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c54257392.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c54257392.cfilter(c,tp)
	return c:IsControler(tp) and c:IsPreviousLocation(LOCATION_DECK) and c:IsReason(REASON_EFFECT)
end
function c54257392.drfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x2151)
end
function c54257392.drcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c54257392.cfilter,1,nil,1-tp) and rp==1-tp
		and Duel.IsExistingMatchingCard(c54257392.drfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c54257392.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c54257392.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
