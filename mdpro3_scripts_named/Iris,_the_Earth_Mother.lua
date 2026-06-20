--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 地母神 艾莉丝  (ID: 9628664)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 6
-- ATK 2400 | DEF 1200
--
-- Effect Text:
-- 连锁积累有3个的场合，从自己卡组抽1张卡。同1组连锁上有复数次同名卡的效果发动的场合，这个效果不能发动。
--[[ __CARD_HEADER_END__ ]]

--地母神アイリス
function c9628664.initial_effect(c)
	--chain
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c9628664.chop)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(9628664,0))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_CHAIN_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c9628664.drcon)
	e2:SetTarget(c9628664.drtg)
	e2:SetOperation(c9628664.drop)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
end
function c9628664.chop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetCurrentChain()
	if ct==1 then
		e:SetLabel(0)
	elseif not Duel.CheckChainUniqueness() then
		e:SetLabel(2)
	elseif ct>=3 and e:GetLabel()~=2 then
		e:SetLabel(1)
	end
end
function c9628664.drcon(e,tp,eg,ep,ev,re,r,rp)
	local res=e:GetLabelObject():GetLabel()
	e:GetLabelObject():SetLabel(0)
	return res==1
end
function c9628664.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c9628664.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
