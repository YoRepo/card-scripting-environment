--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 调和支援士  (ID: 92676637)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Machine
-- Level 1
-- ATK 100 | DEF 300
--
-- Effect Text:
-- ①：把场上的这张卡作为同调素材的场合，这张卡可以当作2星怪兽使用。
-- ②：这张卡作为同调素材送去墓地的场合发动。自己从卡组抽1张。
--[[ __CARD_HEADER_END__ ]]

--チューニング・サポーター
function c92676637.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(92676637,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCondition(c92676637.drcon)
	e1:SetTarget(c92676637.drtg)
	e1:SetOperation(c92676637.drop)
	c:RegisterEffect(e1)
	--synchro level
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SYNCHRO_LEVEL)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c92676637.slevel)
	c:RegisterEffect(e2)
end
function c92676637.slevel(e,c)
	local lv=aux.GetCappedLevel(e:GetHandler())
	return (2<<16)+lv
end
function c92676637.drcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and r==REASON_SYNCHRO
end
function c92676637.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c92676637.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
