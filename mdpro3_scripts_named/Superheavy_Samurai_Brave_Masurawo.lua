--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 超重天神 益荒男-O  (ID: 64193046)
-- Type: Monster / Effect / Synchro
-- Attribute: EARTH
-- Race: Machine
-- Level 12
-- ATK 2100 | DEF 4000
-- Setcode: 154
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 这个卡名在规则上也当作「超重武者」卡使用。
-- ①：这张卡可以用表侧守备表示的状态作出攻击。那个场合，这张卡用守备力当作攻击力使用进行伤害计算。
-- ②：自己场上的「超重武者」怪兽被战斗·效果破坏的场合，可以作为代替把自己场上1张「超重武者」卡破坏。
-- ③：1回合1次，对方把魔法·陷阱卡的效果发动的场合才能发动。自己直到手卡变成3张为止从卡组抽卡。
--[[ __CARD_HEADER_END__ ]]

--超重天神マスラ－O
function c64193046.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--defense attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DEFENSE_ATTACK)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c64193046.reptg)
	e2:SetValue(c64193046.repval)
	e2:SetOperation(c64193046.repop)
	c:RegisterEffect(e2)
	--draw
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(64193046,0))
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_PLAYER_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c64193046.drcon)
	e3:SetTarget(c64193046.drtg)
	e3:SetOperation(c64193046.drop)
	c:RegisterEffect(e3)
end
function c64193046.filter1(c,tp)
	return not c:IsReason(REASON_REPLACE) and c:IsLocation(LOCATION_MZONE) and c:IsControler(tp)
		and c:IsFaceup() and c:IsSetCard(0x9a) and c:IsReason(REASON_EFFECT+REASON_BATTLE)
end
function c64193046.filter2(c,e)
	return c:IsSetCard(0x9a) and c:IsFaceup() and c:IsDestructable(e) and not c:IsStatus(STATUS_DESTROY_CONFIRMED)
end
function c64193046.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=eg:Filter(c64193046.filter1,nil,tp)
	local tg=Duel.GetMatchingGroup(c64193046.filter2,tp,LOCATION_ONFIELD,0,nil,e)
	if chk==0 then return #g>0 and #tg>0 end
	if Duel.SelectEffectYesNo(tp,e:GetHandler(),96) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESREPLACE)
		local xg=tg:Select(tp,1,1,nil)
		Duel.SetTargetCard(xg)
		xg:GetFirst():SetStatus(STATUS_DESTROY_CONFIRMED,true)
		return true
	else return false end
end
function c64193046.repval(e,c)
	return c64193046.filter1(c,e:GetHandlerPlayer())
end
function c64193046.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,64193046)
	local tc=Duel.GetFirstTarget()
	tc:SetStatus(STATUS_DESTROY_CONFIRMED,false)
	Duel.Destroy(tc,REASON_EFFECT+REASON_REPLACE)
end
function c64193046.drcon(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and re:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end
function c64193046.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local h=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	if chk==0 then return h<3 and Duel.IsPlayerCanDraw(tp,3-h) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(3-h)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,3-h)
end
function c64193046.drop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local h=Duel.GetFieldGroupCount(p,LOCATION_HAND,0)
	if h>=3 then return end
	Duel.Draw(p,3-h,REASON_EFFECT)
end
