--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 魔法防护器  (ID: 61844784)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 选择自己场上表侧表示存在的1张魔法卡才能发动。给选择的卡放置1个指示物。选择的卡被破坏的场合，作为代替把1个指示物取除。
--[[ __CARD_HEADER_END__ ]]

--マジック・ガードナー
function c61844784.initial_effect(c)
	--destroy rep
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c61844784.addct)
	e1:SetOperation(c61844784.addc)
	c:RegisterEffect(e1)
end
function c61844784.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL) and c:IsCanAddCounter(0x102a,1)
end
function c61844784.addct(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(tp) and c61844784.filter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c61844784.filter,tp,LOCATION_SZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(61844784,0))
	Duel.SelectTarget(tp,c61844784.filter,tp,LOCATION_SZONE,0,1,1,e:GetHandler())
end
function c61844784.addc(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		tc:AddCounter(0x102a,1)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EFFECT_DESTROY_REPLACE)
		e1:SetTarget(c61844784.reptg)
		e1:SetOperation(c61844784.repop)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
function c61844784.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return bit.band(r,REASON_RULE)==0
		and e:GetHandler():GetCounter(0x102a)>0 end
	return true
end
function c61844784.repop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RemoveCounter(tp,0x102a,1,REASON_EFFECT)
end
