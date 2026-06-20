--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 娱乐法师 帽子戏法师  (ID: 31292357)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Spellcaster
-- Level 4
-- ATK 1100 | DEF 1100
-- Setcode: 198
--
-- Effect Text:
-- ①：场上有怪兽2只以上存在的场合，这张卡可以从手卡特殊召唤。
-- ②：给与自己伤害的魔法·陷阱·怪兽的效果发动时才能发动。给这张卡放置1个娱乐法师指示物（最多3个）。那之后，那个效果让自己受到的伤害变成0。
-- ③：这张卡有娱乐法师指示物被放置，那些娱乐法师指示物变成3个时，这张卡的攻击力·守备力变成3300。
--[[ __CARD_HEADER_END__ ]]

--Emハットトリッカー
function c31292357.initial_effect(c)
	c:EnableCounterPermit(0x36)
	c:SetCounterLimit(0x36,3)
	--special summon rule
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCondition(c31292357.spcon)
	c:RegisterEffect(e1)
	--counter
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_COUNTER)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(aux.damcon1)
	e2:SetTarget(c31292357.cttg)
	e2:SetOperation(c31292357.ctop)
	c:RegisterEffect(e2)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_ADD_COUNTER+0x36)
	e3:SetCondition(c31292357.atkcon)
	e3:SetOperation(c31292357.atkop)
	c:RegisterEffect(e3)
end
function c31292357.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,LOCATION_MZONE)>=2
end
function c31292357.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanAddCounter(0x36,1) end
end
function c31292357.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:AddCounter(0x36,1) then
		local cid=Duel.GetChainInfo(ev,CHAININFO_CHAIN_ID)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CHANGE_DAMAGE)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetTargetRange(1,0)
		e1:SetLabel(cid)
		e1:SetValue(c31292357.damval)
		e1:SetReset(RESET_CHAIN)
		Duel.RegisterEffect(e1,tp)
	end
end
function c31292357.damval(e,re,val,r,rp,rc)
	local cc=Duel.GetCurrentChain()
	if cc==0 or bit.band(r,REASON_EFFECT)==0 then return val end
	local cid=Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)
	if cid~=e:GetLabel() then return val end
	return 0
end
function c31292357.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetCounter(0x36)==3
end
function c31292357.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetValue(3300)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
	c:RegisterEffect(e2)
end
