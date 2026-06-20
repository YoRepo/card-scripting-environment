--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 玛特  (ID: 18631392)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: LIGHT
-- Race: Fairy
-- Level 10
-- ATK ? | DEF ?
--
-- Effect Text:
-- 这张卡不能通常召唤。把自己场上表侧表示存在的1只龙族·光属性怪兽和1只天使族·光属性怪兽送去墓地的场合才能特殊召唤。1回合1次，宣言3个卡名才能发动。从自己卡组上面把3张卡翻开，宣言的卡加入手卡。那以
-- 外的翻开的卡全部送去墓地。这张卡的攻击力·守备力变成这个效果加入手卡的卡数量×1000的数值。
--[[ __CARD_HEADER_END__ ]]

--マアト
function c18631392.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c18631392.spcon)
	e2:SetTarget(c18631392.sptg)
	e2:SetOperation(c18631392.spop)
	c:RegisterEffect(e2)
	--announce 3 cards
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(18631392,0))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_DECKDES+CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c18631392.anctg)
	c:RegisterEffect(e3)
end
function c18631392.spfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsAbleToGraveAsCost()
end
function c18631392.fselect(g,tp)
	return aux.mzctcheck(g,tp) and aux.gfcheck(g,Card.IsRace,RACE_FAIRY,RACE_DRAGON)
end
function c18631392.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c18631392.spfilter,tp,LOCATION_MZONE,0,nil)
	return g:CheckSubGroup(c18631392.fselect,2,2,tp)
end
function c18631392.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c18631392.spfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local sg=g:SelectSubGroup(tp,c18631392.fselect,true,2,2,tp)
	if sg then
		sg:KeepAlive()
		e:SetLabelObject(sg)
		return true
	else return false end
end
function c18631392.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.SendtoGrave(g,REASON_SPSUMMON)
	g:DeleteGroup()
end
function c18631392.anctg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if not Duel.IsPlayerCanDiscardDeck(tp,3) then return false end
		local g=Duel.GetDecktopGroup(tp,3)
		return g:FilterCount(Card.IsAbleToHand,nil)>0
	end
	getmetatable(e:GetHandler()).announce_filter={TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ+TYPE_LINK,OPCODE_ISTYPE,OPCODE_NOT}
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CODE)
	local ac1=Duel.AnnounceCard(tp,table.unpack(getmetatable(e:GetHandler()).announce_filter))
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CODE)
	local ac2=Duel.AnnounceCard(tp,table.unpack(getmetatable(e:GetHandler()).announce_filter))
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CODE)
	local ac3=Duel.AnnounceCard(tp,table.unpack(getmetatable(e:GetHandler()).announce_filter))
	e:SetOperation(c18631392.retop(ac1,ac2,ac3))
end
function c18631392.hfilter(c,code1,code2,code3)
	return c:IsCode(code1,code2,code3) and c:IsAbleToHand()
end
function c18631392.retop(code1,code2,code3)
	return
		function (e,tp,eg,ep,ev,re,r,rp)
			if not Duel.IsPlayerCanDiscardDeck(tp,3) then return end
			local c=e:GetHandler()
			Duel.ConfirmDecktop(tp,3)
			local g=Duel.GetDecktopGroup(tp,3)
			local hg=g:Filter(c18631392.hfilter,nil,code1,code2,code3)
			g:Sub(hg)
			if hg:GetCount()~=0 then
				Duel.DisableShuffleCheck()
				Duel.SendtoHand(hg,nil,REASON_EFFECT)
				Duel.ConfirmCards(1-tp,hg)
				Duel.ShuffleHand(tp)
			end
			if g:GetCount()~=0 then
				Duel.DisableShuffleCheck()
				Duel.SendtoGrave(g,REASON_EFFECT+REASON_REVEAL)
			end
			if c:IsRelateToEffect(e) then
				local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_SET_ATTACK_FINAL)
				e1:SetValue(hg:GetCount()*1000)
				e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
				c:RegisterEffect(e1)
				local e2=e1:Clone()
				e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
				c:RegisterEffect(e2)
			end
		end
end
