--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: No.67 平行骰子天堂锤手  (ID: 35772782)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Fairy
-- Rank 5
-- ATK 2100 | DEF 2100
-- Setcode: 72
--
-- Effect Text:
-- 5星怪兽×2只以上
-- ①：1回合1次，自己主要阶段1把这张卡2个超量素材取除才能发动。双方各掷2次骰子。出现的数目合计大的玩家直到下个回合的结束时不能把怪兽的效果发动，不能攻击宣言。
-- ②：持有超量素材的这张卡在怪兽区域存在，自己或者对方掷骰子的场合，1回合只有1次可以把那之内1个数目作为7适用。
--[[ __CARD_HEADER_END__ ]]

--No.67 パラダイスマッシャー
function c35772782.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,5,2,nil,nil,99)
	c:EnableReviveLimit()
	--dice
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(35772782,0))
	e1:SetCategory(CATEGORY_DICE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c35772782.dccon)
	e1:SetCost(c35772782.dccost)
	e1:SetTarget(c35772782.dctg)
	e1:SetOperation(c35772782.dcop)
	c:RegisterEffect(e1)
	--dice
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_TOSS_DICE_NEGATE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c35772782.dicecon)
	e2:SetOperation(c35772782.diceop)
	c:RegisterEffect(e2)
end
aux.xyz_number[35772782]=67
function c35772782.dccon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1
end
function c35772782.dccost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,2,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,2,2,REASON_COST)
end
function c35772782.dctg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,PLAYER_ALL,2)
end
function c35772782.dcop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local d1,d2,d3,d4=Duel.TossDice(tp,2,2)
	if d1+d2>d3+d4 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_CANNOT_ACTIVATE)
		e1:SetTargetRange(1,0)
		e1:SetValue(c35772782.actlimit)
		e1:SetReset(RESET_PHASE+PHASE_END,2)
		Duel.RegisterEffect(e1,tp)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e2:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
		e2:SetTargetRange(1,0)
		e2:SetReset(RESET_PHASE+PHASE_END,2)
		Duel.RegisterEffect(e2,tp)
	elseif d1+d2<d3+d4 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_CANNOT_ACTIVATE)
		e1:SetTargetRange(0,1)
		e1:SetValue(c35772782.actlimit)
		e1:SetReset(RESET_PHASE+PHASE_END,2)
		Duel.RegisterEffect(e1,tp)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e2:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
		e2:SetTargetRange(0,1)
		e2:SetReset(RESET_PHASE+PHASE_END,2)
		Duel.RegisterEffect(e2,tp)
	end
end
function c35772782.actlimit(e,re,tp)
	return re:IsActiveType(TYPE_MONSTER)
end
function c35772782.dicecon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetOverlayCount()>0 and c:GetFlagEffect(35772782)==0
end
function c35772782.diceop(e,tp,eg,ep,ev,re,r,rp)
	local cc=Duel.GetCurrentChain()
	local cid=Duel.GetChainInfo(cc,CHAININFO_CHAIN_ID)
	if Duel.SelectYesNo(tp,aux.Stringid(35772782,1)) then
		Duel.Hint(HINT_CARD,0,35772782)
		e:GetHandler():RegisterFlagEffect(35772782,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
		local dc={Duel.GetDiceResult()}
		local ac=1
		local ct=(ev&0xff)+(ev>>16&0xff)
		if ct>1 then
			--choose the index of results
			Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(35772782,2))
			local val,idx=Duel.AnnounceNumber(tp,table.unpack(aux.idx_table,1,ct))
			ac=idx+1
		end
		dc[ac]=7
		Duel.SetDiceResult(table.unpack(dc))
	end
end
