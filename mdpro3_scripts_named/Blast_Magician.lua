--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 血魔术师-炼狱的魔术师-  (ID: 21051146)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Spellcaster
-- Level 4
-- ATK 1400 | DEF 1700
-- Setcode: 197
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，每次自己或者对方把魔法卡发动，给这张卡放置魔力指示物。可以把这张卡放置的魔力指示物任意数量取除，持有取除数量×700的数值以下的攻击力的场上表侧表示存在的1只怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--ブラッド・マジシャン－煉獄の魔術師－
function c21051146.initial_effect(c)
	c:EnableCounterPermit(0x1)
	--add counter
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e0:SetCode(EVENT_CHAINING)
	e0:SetRange(LOCATION_MZONE)
	e0:SetOperation(aux.chainreg)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetCode(EVENT_CHAIN_SOLVED)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c21051146.acop)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21051146,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetTarget(c21051146.destg)
	e2:SetOperation(c21051146.desop)
	c:RegisterEffect(e2)
end
function c21051146.acop(e,tp,eg,ep,ev,re,r,rp)
	if re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL) and e:GetHandler():GetFlagEffect(FLAG_ID_CHAINING)>0 then
		e:GetHandler():AddCounter(0x1,1)
	end
end
function c21051146.filter(c,cc,tp)
	local ct=math.ceil(c:GetAttack()/700)
	if ct==0 then ct=1 end
	return c:IsFaceup() and cc:IsCanRemoveCounter(tp,0x1,ct,REASON_COST)
end
function c21051146.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c21051146.filter(chkc,e:GetHandler(),tp) end
	if chk==0 then return Duel.IsExistingTarget(c21051146.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,e:GetHandler(),tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c21051146.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,e:GetHandler(),tp)
	local ct=math.ceil(g:GetFirst():GetAttack()/700)
	if ct==0 then ct=1 end
	e:GetHandler():RemoveCounter(tp,0x1,ct,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c21051146.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
